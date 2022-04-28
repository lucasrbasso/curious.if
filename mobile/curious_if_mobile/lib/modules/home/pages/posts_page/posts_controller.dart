import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/core.dart';
import '../../../../domain/login/model/user_model.dart';
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

  @observable
  PostsState state = PostsStateEmpty();

  @observable
  List<PostModel> posts = [];

  @action
  Future<void> _modifyPostsState(PostsState stateModify) async =>
      state = stateModify;

  @action
  Future<void> listPosts(UserModel user) async {
    try {
      await _modifyPostsState(PostsStateLoading());
      List<PostModel> posts = await _postUsecase.listPosts(token: user.token);
      await _modifyPostsState(PostsStateSuccess(
          message: "Posts buscados com sucesso", posts: posts));
    } catch (e) {
      await _modifyPostsState(PostsStateFailure(message: e.toString()));
    }
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
    autorun((_) async {
      if (state is PostsStateFailure) {
        String message = (state as PostsStateFailure).message;
        await _modifyPostsState(PostsStateEmpty());
        showSnackBar(context, message, Colors.red);
      } else if (state is PostsStateSuccess) {
        String message = (state as PostsStateSuccess).message;
        await _modifyPostsState(PostsStateEmpty());
        showSnackBar(context, message, Colors.green);
      }
    });
  }

  void dispose() {}
}
