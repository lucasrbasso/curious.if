// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostsController on _PostsControllerBase, Store {
  final _$stateAtom = Atom(name: '_PostsControllerBase.state');

  @override
  PostsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(PostsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_modifyPostsStateAsyncAction =
      AsyncAction('_PostsControllerBase._modifyPostsState');

  @override
  Future<void> _modifyPostsState(PostsState stateModify) {
    return _$_modifyPostsStateAsyncAction
        .run(() => super._modifyPostsState(stateModify));
  }

  final _$listPostsAsyncAction = AsyncAction('_PostsControllerBase.listPosts');

  @override
  Future<void> listPosts(UserModel user) {
    return _$listPostsAsyncAction.run(() => super.listPosts(user));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
