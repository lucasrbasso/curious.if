// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CreatePostController on _CreatePostControllerBase, Store {
  final _$stateAtom = Atom(name: '_CreatePostControllerBase.state');

  @override
  CreatePostState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(CreatePostState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$loadingShimmerAtom =
      Atom(name: '_CreatePostControllerBase.loadingShimmer');

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

  final _$_modifyCreatePostStateAsyncAction =
      AsyncAction('_CreatePostControllerBase._modifyCreatePostState');

  @override
  Future<void> _modifyCreatePostState(CreatePostState stateModify) {
    return _$_modifyCreatePostStateAsyncAction
        .run(() => super._modifyCreatePostState(stateModify));
  }

  final _$listPostsAsyncAction =
      AsyncAction('_CreatePostControllerBase.listPosts');

  @override
  Future<void> listPosts({required UserModel user, String? cursorID}) {
    return _$listPostsAsyncAction
        .run(() => super.listPosts(user: user, cursorID: cursorID));
  }

  final _$_CreatePostControllerBaseActionController =
      ActionController(name: '_CreatePostControllerBase');

  @override
  void modifyShimmer(int length) {
    final _$actionInfo = _$_CreatePostControllerBaseActionController
        .startAction(name: '_CreatePostControllerBase.modifyShimmer');
    try {
      return super.modifyShimmer(length);
    } finally {
      _$_CreatePostControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
loadingShimmer: ${loadingShimmer}
    ''';
  }
}
