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

  final _$_modifyCreatePostStateAsyncAction =
      AsyncAction('_CreatePostControllerBase._modifyCreatePostState');

  @override
  Future<void> _modifyCreatePostState(CreatePostState stateModify) {
    return _$_modifyCreatePostStateAsyncAction
        .run(() => super._modifyCreatePostState(stateModify));
  }

  final _$createPostAsyncAction =
      AsyncAction('_CreatePostControllerBase.createPost');

  @override
  Future<bool> createPost({required UserModel user, required String content}) {
    return _$createPostAsyncAction
        .run(() => super.createPost(user: user, content: content));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
