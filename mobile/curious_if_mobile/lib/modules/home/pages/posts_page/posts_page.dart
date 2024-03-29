import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:curious_if_mobile/modules/home/pages/posts_page/widgets/popup_comments/popup_comments.dart';

import '../../../../core/core.dart';
import '../../../../core/routes/verify_roles.dart';
import '../../../../domain/login/model/user_model.dart';
import '../../../../domain/post/model/post_model.dart';
import 'posts_controller.dart';
import 'widgets/popup_report/popup_report.dart';
import 'widgets/post_widget/post_widget.dart';

class PostsPage extends StatefulWidget {
  final UserModel? user;
  const PostsPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late PostsController _postsController;
  final List<PostModel> posts = [];

  @override
  void initState() {
    _postsController = PostsController();
    _postsController.listPosts(id: widget.user?.id);
    _postsController.autoRun(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      int itemCount =
          _postsController.posts.length + _postsController.loadingShimmer;
      log(itemCount.toString());
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) => _postsController.scrollInfo(scrollInfo),
        child: RefreshIndicator(
          onRefresh: () async {
            await _postsController.refreshScroll(widget.user?.id);
          },
          color: AppTheme.colors.titlePost,
          backgroundColor: AppTheme.colors.backgroundButton,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (index < _postsController.posts.length) {
                return PostWidget(
                    post: _postsController.posts[index],
                    onDenounce: () async {
                      if (widget.user != null) {
                        await Future.delayed(
                          const Duration(seconds: 0),
                          () => Navigator.canPop(context),
                        );
                        await showDialog(
                          useRootNavigator: false,
                          context: context,
                          builder: (BuildContext dialogContext) {
                            return PopupReport(
                              onSaved: (content) async {
                                bool isReported =
                                    await _postsController.reportPost(
                                        _postsController.posts[index],
                                        content,
                                        widget.user!.token);
                                if (isReported) {
                                  _postsController.showSnackBar(context,
                                      "Denunciado com sucesso!", Colors.green);
                                }
                                Navigator.maybePop(context);
                                return isReported;
                              },
                            );
                          },
                        );
                      } else {
                        _postsController.showSnackBar(
                            context,
                            "Você precisa estar logado para denunciar!",
                            Colors.red);
                      }
                    },
                    onTapComment: () async {
                      dynamic response = await showDialog(
                        context: context,
                        useRootNavigator: false,
                        builder: (BuildContext dialogContext) {
                          return PopupComments(
                            post: _postsController.posts[index],
                            user: widget.user,
                          );
                        },
                      );
                      if (response is int && response != 0) {
                        _postsController.posts[index] =
                            _postsController.posts[index].copyWith(
                                numberOfComments: _postsController
                                        .posts[index].numberOfComments +
                                    response);
                      }
                    },
                    onTapLike: (isLiked) async {
                      if (widget.user != null &&
                          VerifyRoles.verifyCanPost(widget.user)) {
                        return await _postsController.likePost(
                          !isLiked,
                          _postsController.posts[index],
                          widget.user!.token,
                        );
                      } else if (widget.user != null) {
                        _postsController.showSnackBar(
                            context, "Sua conta está em análise!", Colors.red);
                      }
                      return null;
                    });
              } else {
                return PostWidget(
                  post: PostModel.mock(),
                  loading: true,
                  onTapComment: () {},
                  onDenounce: () async {},
                  onTapLike: (isLiked) async {
                    return null;
                  },
                );
              }
            },
          ),
        ),
      );
    });
  }
}
