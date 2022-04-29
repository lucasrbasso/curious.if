import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:sizer/sizer.dart';
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

  @observable
  int loadingShimmer = 5;

  bool last = false;

  @action
  void modifyShimmer(int length) => loadingShimmer = length;

  @action
  Future<void> _modifyCreatePostState(CreatePostState stateModify) async =>
      state = stateModify;

  @action
  Future<void> listPosts({required UserModel user, String? cursorID}) async {
    try {
      await _modifyCreatePostState(CreatePostStateLoading());
      List<PostModel> posts = await _postUsecase.listPosts(
        token: user.token,
        cursorID: cursorID ?? '',
      );
      if (cursorID == null) {
        last = false;
      }
      await Future.delayed(const Duration(seconds: 5));
      // if (posts.isEmpty || posts.length < 10) last = true;
      // await _modifyCreatePostState(CreatePostStateSuccess(
      //     message: "Posts buscados com sucesso", posts: []));
    } catch (e) {
      await _modifyCreatePostState(
          CreatePostStateFailure(message: e.toString()));
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
    reactionDisposer = autorun((_) async {
      if (state is CreatePostStateFailure) {
        modifyShimmer(0);
        String message = (state as CreatePostStateFailure).message;
        await _modifyCreatePostState(CreatePostStateEmpty());
        showSnackBar(context, message, Colors.red);
      } else if (state is CreatePostStateSuccess) {
        modifyShimmer(0);
        String message = (state as CreatePostStateSuccess).message;
        await _modifyCreatePostState(CreatePostStateEmpty());
        showSnackBar(context, message, Colors.green);
      } else if (state is CreatePostStateLoading) {
        modifyShimmer(5);
      }
    });
  }

  void dispose() {
    _postUsecase.dispose();
    reactionDisposer.reaction.dispose();
  }
}
