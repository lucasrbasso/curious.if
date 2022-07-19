import 'package:curious_if_mobile/modules/home/pages/posts_page/widgets/popup_comments/popup_comments_state.dart';
import 'package:curious_if_mobile/shared/settings_widgets/text_form_custom/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/routes/verify_roles.dart';
import '../../../../../../domain/login/model/user_model.dart';
import '../../../../../../domain/post/model/post_model.dart';
import '../../../../../../shared/shimmer_row/shimmer_row_widget.dart';
import '../../../../../../shared/text_form_input/text_form_input.dart';
import 'popup_comments_controller.dart';
import 'widgets/comment_widget.dart';
import 'widgets/create_comment_widget.dart';
import 'widgets/post_comment_widget.dart';
import 'widgets/shimmer_comment_widget.dart';

class PopupComments extends StatefulWidget {
  final UserModel? user;
  final PostModel post;
  const PopupComments({
    Key? key,
    required this.user,
    required this.post,
  }) : super(key: key);

  @override
  State<PopupComments> createState() => _PopupCommentsState();
}

class _PopupCommentsState extends State<PopupComments> {
  late PopupCommentsController popupCommentsController;
  @override
  void initState() {
    popupCommentsController = PopupCommentsController();
    popupCommentsController.getAllCommentsPost(widget.post.id, widget.user?.id);
    popupCommentsController.autoRun(context);
    super.initState();
  }

  @override
  void dispose() {
    popupCommentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context, rootNavigator: true)
            .pop(popupCommentsController.numberOfCommentsAddOrExclude);
        return false;
      },
      child: AlertDialog(
        insetPadding: const EdgeInsets.only(bottom: 24),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0))),
        contentPadding: EdgeInsets.zero,
        titlePadding: const EdgeInsets.only(right: 8, top: 8),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => Navigator.maybePop(context),
              borderRadius: BorderRadius.circular(20),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.cancel_outlined, color: Colors.red),
              ),
            ),
          ],
        ),
        content: Container(
          width: 90.w,
          height: 80.h,
          padding: EdgeInsets.only(bottom: 12),
          child: Scrollbar(
            isAlwaysShown: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PostCommentWidget(post: widget.post),
                  if (widget.user != null) ...[
                    CreateCommentWidget(
                      onSaved: (value) async {
                        return await popupCommentsController.createComment(
                            value, widget.post.id, widget.user!.token);
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 12),
                  Observer(builder: (context) {
                    print(popupCommentsController.state
                        is PopupCommentsStateSuccess);
                    return Column(
                      children: [
                        if (popupCommentsController.state
                            is PopupCommentsStateLoading) ...[
                          ShimmerCommentWidget(),
                          ShimmerCommentWidget(),
                          ShimmerCommentWidget(),
                        ] else if (popupCommentsController.state
                            is PopupCommentsStateSuccess) ...[
                          ...popupCommentsController.comments.map((comment) {
                            print(comment);
                            return CommentWidget(
                              commentModel: comment,
                              onDelete: () async {
                                return await popupCommentsController
                                    .deleteComment(comment, widget.user!.token);
                              },
                              onTapLike: (isLiked) async {
                                if (widget.user != null &&
                                    VerifyRoles.verifyCanPost(widget.user)) {
                                  return await popupCommentsController
                                      .likeComment(
                                    !isLiked,
                                    comment,
                                    widget.user!.token,
                                  );
                                } else if (widget.user != null) {
                                  popupCommentsController.showSnackBar(context,
                                      "Sua conta está em análise!", Colors.red);
                                }
                                return null;
                              },
                            );
                          }).toList()
                        ]
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: AppTheme.colors.background,
      ),
    );
  }
}
