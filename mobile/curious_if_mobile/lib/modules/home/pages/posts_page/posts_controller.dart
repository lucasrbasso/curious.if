import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/core.dart';
import '../../../../domain/post/model/post_model.dart';
import '../../../../domain/post/usecase/post_usecase.dart';
import 'posts_state.dart';
part 'posts_controller.g.dart';

class PostsController extends _PostsControllerBase with _$PostsController {
  PostsController({IPostUseCase? postUsecase}) {
    _postUsecase = postUsecase ?? PostUseCase();
  }
}

abstract class _PostsControllerBase with Store {
  late IPostUseCase _postUsecase;

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
  Future<void> listPosts({String? cursorID}) async {
    try {
      await _modifyPostsState(PostsStateLoading());

      await Future.delayed(const Duration(seconds: 1));
      List<PostModel> posts =
          await _postUsecase.listPosts(cursorID: cursorID ?? '');
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

  Future<void> refreshScroll() async {
    if ((state is! PostsStateLoading) || posts.isNotEmpty) {
      posts.removeWhere((element) => true);
      await listPosts();
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

  void dispose() {
    _postUsecase.dispose();
    reactionDisposer.reaction.dispose();
  }
}
