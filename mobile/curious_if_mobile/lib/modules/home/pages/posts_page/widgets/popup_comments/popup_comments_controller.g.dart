// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popup_comments_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PopupCommentsController on _PopupCommentsControllerBase, Store {
  late final _$isVisibleAtom =
      Atom(name: '_PopupCommentsControllerBase.isVisible', context: context);

  @override
  bool get isVisible {
    _$isVisibleAtom.reportRead();
    return super.isVisible;
  }

  @override
  set isVisible(bool value) {
    _$isVisibleAtom.reportWrite(value, super.isVisible, () {
      super.isVisible = value;
    });
  }

  late final _$stateAtom =
      Atom(name: '_PopupCommentsControllerBase.state', context: context);

  @override
  PopupCommentsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(PopupCommentsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$commentsAtom =
      Atom(name: '_PopupCommentsControllerBase.comments', context: context);

  @override
  ObservableList<CommentModel> get comments {
    _$commentsAtom.reportRead();
    return super.comments;
  }

  @override
  set comments(ObservableList<CommentModel> value) {
    _$commentsAtom.reportWrite(value, super.comments, () {
      super.comments = value;
    });
  }

  late final _$loadingShimmerAtom = Atom(
      name: '_PopupCommentsControllerBase.loadingShimmer', context: context);

  @override
  int get loadingShimmer {
    _$loadingShimmerAtom.reportRead();
    return super.loadingShimmer;
  }

  @override
  set loadingShimmer(int value) {
    _$loadingShimmerAtom.reportWrite(value, super.loadingShimmer, () {
      super.loadingShimmer = value;
    });
  }

  late final _$_modifyPopupCommentsStateAsyncAction = AsyncAction(
      '_PopupCommentsControllerBase._modifyPopupCommentsState',
      context: context);

  @override
  Future<void> _modifyPopupCommentsState(PopupCommentsState stateModify) {
    return _$_modifyPopupCommentsStateAsyncAction
        .run(() => super._modifyPopupCommentsState(stateModify));
  }

  late final _$getAllCommentsPostAsyncAction = AsyncAction(
      '_PopupCommentsControllerBase.getAllCommentsPost',
      context: context);

  @override
  Future<void> getAllCommentsPost(String postId, String? userId) {
    return _$getAllCommentsPostAsyncAction
        .run(() => super.getAllCommentsPost(postId, userId));
  }

  late final _$createCommentAsyncAction = AsyncAction(
      '_PopupCommentsControllerBase.createComment',
      context: context);

  @override
  Future<bool> createComment(String content, String postId, String token) {
    return _$createCommentAsyncAction
        .run(() => super.createComment(content, postId, token));
  }

  late final _$deleteCommentAsyncAction = AsyncAction(
      '_PopupCommentsControllerBase.deleteComment',
      context: context);

  @override
  Future<bool> deleteComment(CommentModel comment, String token) {
    return _$deleteCommentAsyncAction
        .run(() => super.deleteComment(comment, token));
  }

  late final _$_PopupCommentsControllerBaseActionController =
      ActionController(name: '_PopupCommentsControllerBase', context: context);

  @override
  void modifyIsVisible(bool newIsVisible) {
    final _$actionInfo = _$_PopupCommentsControllerBaseActionController
        .startAction(name: '_PopupCommentsControllerBase.modifyIsVisible');
    try {
      return super.modifyIsVisible(newIsVisible);
    } finally {
      _$_PopupCommentsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void modifyShimmer(int length) {
    final _$actionInfo = _$_PopupCommentsControllerBaseActionController
        .startAction(name: '_PopupCommentsControllerBase.modifyShimmer');
    try {
      return super.modifyShimmer(length);
    } finally {
      _$_PopupCommentsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isVisible: ${isVisible},
state: ${state},
comments: ${comments},
loadingShimmer: ${loadingShimmer}
    ''';
  }
}
