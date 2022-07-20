import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../core/core.dart';
import '../../../domain/login/model/user_model.dart';
import '../../../domain/management/model/post_management_model.dart';
import '../../../shared/app_bar_simple/app_bar_simple.dart';
import 'manage_post_controller.dart';
import 'manage_post_state.dart';
import 'widgets/post_manage_widget/post_manage_widget.dart';
import 'widgets/slidable_card/slidable_card_widget.dart';

class ManagePostPage extends StatefulWidget {
  final UserModel user;
  const ManagePostPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<ManagePostPage> createState() => _ManagePostPageState();
}

class _ManagePostPageState extends State<ManagePostPage> {
  late ManagePostController _managePostController;
  late GlobalKey<AnimatedListState> _listKey;
  final List<PostManagementModel> posts = [];

  @override
  void initState() {
    _listKey = GlobalKey<AnimatedListState>();
    _managePostController = ManagePostController();
    _managePostController.getListPostsUnauthorized(
        token: widget.user.token, listKey: _listKey);
    _managePostController.autoRun(context);
    super.initState();
  }

  @override
  void dispose() {
    _managePostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () async {
        print(_managePostController.postsHome);
        Navigator.of(context, rootNavigator: true)
            .pop(_managePostController.postsHome);
        return false;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppThemeController().colorStatus,
        sized: false,
        child: Scaffold(
          backgroundColor: AppTheme.colors.background,
          appBar: AppBarSimple(
            label: "GERENCIAR POSTS",
            user: widget.user,
            hasSearch: true,
          ),
          body: Observer(
            builder: (context) {
              log("Teste");
              return RefreshIndicator(
                onRefresh: () async {
                  await _managePostController.refreshScroll(
                      widget.user.token, _listKey);
                },
                color: AppTheme.colors.titlePost,
                backgroundColor: AppTheme.colors.backgroundButton,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (_managePostController.state
                        is! ManagePostStateLoading) ...[
                      SlidableAutoCloseBehavior(
                        child: AnimatedList(
                          padding: const EdgeInsets.only(top: 10),
                          key: _listKey,
                          initialItemCount: _managePostController.posts.length,
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemBuilder: (context, index, animation) {
                            return Column(
                              children: [
                                SlidableCardWidget(
                                  key: Key(_managePostController.posts[index]
                                      .toString()),
                                  onPublishEdit: (context, publish) =>
                                      _managePostController.onPublishEdit(
                                    _managePostController.posts[index].id,
                                    widget.user.token,
                                    () => _managePostController
                                        .onAnimationDeletion(
                                            index, _listKey, context),
                                    publish,
                                  ),
                                  onDismissed: (publish) =>
                                      _managePostController.onDismissed(
                                          index, context, _listKey),
                                  confirmDismiss: (publish) =>
                                      _managePostController.confirmDismiss(
                                    _managePostController.posts[index].id,
                                    widget.user.token,
                                    () => _managePostController
                                        .onAnimationDeletion(
                                            index, _listKey, context),
                                    publish,
                                  ),
                                  post: _managePostController.posts[index],
                                ),
                                const SizedBox(height: 8)
                              ],
                            );
                          },
                        ),
                      )
                    ] else ...[
                      ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              PostManageWidget(
                                  key: UniqueKey(),
                                  post: PostManagementModel.mock(),
                                  loading: true),
                              const SizedBox(height: 8)
                            ],
                          );
                        },
                      ),
                    ]
                  ],
                ),
              );
            },
            // floatingActionButton: FloatingActionButton(onPressed: () async {
            //   try {
            //     await AppThemeController().toggleThemeMode();
            //   } catch (e) {}
            // }),
          ),
        ),
      ),
    );
  }
}
