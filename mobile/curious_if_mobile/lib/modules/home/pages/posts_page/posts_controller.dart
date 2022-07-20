import 'dart:developer';

import 'package:curious_if_mobile/domain/reports/model/report_post.dart';
import 'package:curious_if_mobile/domain/reports/usecase/reports_usecase.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/core.dart';
import '../../../../domain/post/model/post_model.dart';
import '../../../../domain/post/usecase/post_usecase.dart';
import 'posts_state.dart';
part 'posts_controller.g.dart';

class PostsController extends _PostsControllerBase with _$PostsController {
  static final PostsController _postsController = PostsController._internal();

  factory PostsController() => _postsController;

  PostsController._internal();
}

abstract class _PostsControllerBase with Store {
  final IPostUseCase _postUsecase = PostUseCase();
  final IReportsUseCase _reportUsecase = ReportsUseCase();

  late ReactionDisposer reactionDisposer;

  @observable
  PostsState state = PostsStateEmpty();

  @observable
  ObservableList<PostModel> posts = ObservableList.of([]);

  @observable
  int loadingShimmer = 5;

  bool last = false;

  @action
  void modifyShimmer(int length) => loadingShimmer = length;

  @action
  Future<void> _modifyPostsState(PostsState stateModify) async =>
      state = stateModify;

  @action
  Future<void> insertPosts(List<PostModel> newPosts) async {
    posts.insertAll(0, newPosts);
  }

  @action
  Future<void> removePosts(List<String> removePosts) async {
    for (String element in removePosts) {
      posts.removeWhere((elementRemove) => elementRemove.id == element);
    }
  }

  @action
  Future<void> listPosts({String? cursorID, String? id}) async {
    try {
      await _modifyPostsState(PostsStateLoading());

      await Future.delayed(const Duration(seconds: 1));
      List<PostModel> posts =
          await _postUsecase.listPosts(cursorID: cursorID ?? '', id: id);
      if (cursorID == null) {
        last = false;
        this.posts.removeWhere((element) => true);
      }
      this.posts.addAll(posts);
      if (posts.isEmpty || posts.length < 10) last = true;
      await _modifyPostsState(PostsStateSuccess(
          message: "Posts buscados com sucesso", posts: posts));
    } catch (e) {
      await _modifyPostsState(PostsStateFailure(message: e.toString()));
    }
  }

  Future<void> refreshScroll(String? id) async {
    if ((state is! PostsStateLoading) || posts.isNotEmpty) {
      posts.removeWhere((element) => true);
      await listPosts(id: id);
    }
  }

  Future<bool?> likePost(bool isLiked, PostModel post, String token) async {
    try {
      await _postUsecase.setLikePost(
          isLiked: isLiked, id: post.id, token: token);
      return isLiked;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool> reportPost(PostModel post, String content, String token) async {
    try {
      ReportPost report = ReportPost(postId: post.id, content: content);
      await Future.delayed(const Duration(seconds: 2));
      await _reportUsecase.reportPost(report, token);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  bool scrollInfo(ScrollNotification scrollInfo) {
    if (posts.isNotEmpty) {
      if ((scrollInfo.metrics.pixels >
              (scrollInfo.metrics.maxScrollExtent - 10.h)) &&
          state is! PostsStateLoading &&
          !last) {
        listPosts(cursorID: posts.last.id);
      }
      return true;
    }
    return false;
  }

  // FUNÇÃO PARA ABRIR O SNACKBAR
  void showSnackBar(BuildContext context, String text, Color color) {
    SnackBar snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTheme.textStyles.textSnackBar,
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void autoRun(BuildContext context) {
    reactionDisposer = autorun((_) async {
      if (state is PostsStateFailure) {
        modifyShimmer(0);
        String message = (state as PostsStateFailure).message;
        await _modifyPostsState(PostsStateEmpty());
        showSnackBar(context, message, Colors.red);
      } else if (state is PostsStateSuccess) {
        modifyShimmer(0);
        await _modifyPostsState(PostsStateEmpty());
      } else if (state is PostsStateLoading) {
        modifyShimmer(5);
      }
    });
  }
}
