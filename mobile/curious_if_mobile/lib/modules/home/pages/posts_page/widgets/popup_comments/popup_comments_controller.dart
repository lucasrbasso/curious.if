import 'dart:developer';

import 'package:curious_if_mobile/domain/comment/usecase/comment_usecase.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../core/core.dart';
import '../../../../../../domain/comment/model/comment_model.dart';
import 'popup_comments_state.dart';
part 'popup_comments_controller.g.dart';

class PopupCommentsController extends _PopupCommentsControllerBase
    with _$PopupCommentsController {
  PopupCommentsController({ICommentUseCase? commentUseCase}) {
    _commentUseCase = commentUseCase ?? CommentUseCase();
  }
}

abstract class _PopupCommentsControllerBase with Store {
  late ICommentUseCase _commentUseCase;

  late ReactionDisposer reactionDisposer;

  @observable
  PopupCommentsState state = PopupCommentsStateEmpty();

  @observable
  ObservableList<CommentModel> comments = ObservableList.of([]);

  int numberOfCommentsAddOrExclude = 0;

  @observable
  int loadingShimmer = 5;

  @action
  void modifyShimmer(int length) => loadingShimmer = length;

  @action
  Future<void> _modifyPopupCommentsState(
          PopupCommentsState stateModify) async =>
      state = stateModify;

  @action
  Future<void> getAllCommentsPost(String postId, String? userId) async {
    try {
      await _modifyPopupCommentsState(PopupCommentsStateLoading());
      await Future.delayed(const Duration(seconds: 2));
      List<CommentModel> comments =
          await _commentUseCase.getAllCommentsPost(postId, userId);

      this.comments.addAll(comments);
      await _modifyPopupCommentsState(PopupCommentsStateSuccess(
          message: "Comentários buscados com sucesso", comments: comments));
    } catch (e) {
      await _modifyPopupCommentsState(
          PopupCommentsStateFailure(message: e.toString()));
    }
  }

  @action
  Future<bool> createComment(
      String content, String postId, String token) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      CommentModel comment =
          await _commentUseCase.createComment(content, postId, token);
      print(comment);
      numberOfCommentsAddOrExclude++;
      comments.insert(0, comment);
      print(comments);
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool?> likeComment(
      bool isLiked, CommentModel comment, String token) async {
    try {
      await _commentUseCase.setLikeComment(
          isLiked: isLiked, id: comment.id, token: token);
      return isLiked;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @action
  Future<bool> deleteComment(CommentModel comment, String token) async {
    try {
      await _commentUseCase.deleteComment(id: comment.id, token: token);

      numberOfCommentsAddOrExclude--;
      return comments.remove(comment);
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Future<bool?> likePost(bool isLiked, PostModel post, String token) async {
  //   try {
  //     await _postUsecase.setLikePost(
  //         isLiked: isLiked, id: post.id, token: token);
  //     return isLiked;
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return null;
  // }

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
      if (state is PopupCommentsStateFailure) {
        modifyShimmer(0);
        String message = (state as PopupCommentsStateFailure).message;
        await _modifyPopupCommentsState(PopupCommentsStateEmpty());
        // showSnackBar(context, message, Colors.red);
      } else if (state is PopupCommentsStateSuccess) {
        modifyShimmer(0);
      } else if (state is PopupCommentsStateLoading) {
        modifyShimmer(5);
      }
    });
  }

  void dispose() {
    _commentUseCase.dispose();
    reactionDisposer.reaction.dispose();
  }
}
