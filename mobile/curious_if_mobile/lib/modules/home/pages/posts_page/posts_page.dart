import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/core.dart';
import '../../../../core/routes/verify_roles.dart';
import '../../../../domain/login/model/user_model.dart';
import '../../../../domain/post/model/post_model.dart';
import 'posts_controller.dart';
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
    _postsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      int itemCount =
          _postsController.posts.length + _postsController.loadingShimmer;
      print(itemCount);
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
                    onTap: (isLiked) async {
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
                    });
              } else {
                return PostWidget(
                  post: PostModel.mock(),
                  loading: true,
                  onTap: (isLiked) async {},
                );
              }
            },
          ),
        ),
      );
    });
  }
}
