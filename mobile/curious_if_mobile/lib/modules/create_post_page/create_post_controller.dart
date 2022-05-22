import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/core.dart';
import '../../../../domain/login/model/user_model.dart';
import '../../../../domain/post/model/post_model.dart';
import '../../../../domain/post/usecase/post_usecase.dart';
import 'create_post_state.dart';
part 'create_post_controller.g.dart';

class CreatePostController extends _CreatePostControllerBase
    with _$CreatePostController {
  CreatePostController({IPostUseCase? postUsecase}) {
    _postUsecase = postUsecase ?? PostUseCase();
  }
}

abstract class _CreatePostControllerBase with Store {
  late IPostUseCase _postUsecase;

  late ReactionDisposer reactionDisposer;

  @observable
  CreatePostState state = CreatePostStateEmpty();

  @action
  Future<void> _modifyCreatePostState(CreatePostState stateModify) async =>
      state = stateModify;

  @action
  Future<bool> createPost(
      {required UserModel user,
      required String content,
      required String to}) async {
    try {
      await _modifyCreatePostState(CreatePostStateLoading());
      await Future.delayed(const Duration(seconds: 5));
      PostModel post = await _postUsecase.createPost(
        token: user.token,
        to: to,
        content: content,
      );
      // if (posts.isEmpty || posts.length < 10) last = true;
      await _modifyCreatePostState(CreatePostStateSuccess(
          message: "Post criado com sucesso!!!", post: post));
      return true;
    } catch (e) {
      await _modifyCreatePostState(
          CreatePostStateFailure(message: e.toString()));
      return false;
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

  void autoRun(BuildContext context, VoidCallback onSuccess) {
    reactionDisposer = autorun((_) async {
      if (state is CreatePostStateFailure) {
        String message = (state as CreatePostStateFailure).message;
        await _modifyCreatePostState(CreatePostStateEmpty());
        showSnackBar(context, message, Colors.red);
      } else if (state is CreatePostStateSuccess) {
        String message = (state as CreatePostStateSuccess).message;
        await _modifyCreatePostState(CreatePostStateEmpty());
        onSuccess();
        showSnackBar(context, message, Colors.green);
      }
    });
  }

  void dispose() {
    _postUsecase.dispose();
    reactionDisposer.reaction.dispose();
  }
}
