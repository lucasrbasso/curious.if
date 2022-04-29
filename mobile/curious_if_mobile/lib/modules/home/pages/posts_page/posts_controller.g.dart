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

  final _$postsAtom = Atom(name: '_PostsControllerBase.posts');

  @override
  ObservableList<PostModel> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(ObservableList<PostModel> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  final _$loadingShimmerAtom =
      Atom(name: '_PostsControllerBase.loadingShimmer');

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

  final _$_modifyPostsStateAsyncAction =
      AsyncAction('_PostsControllerBase._modifyPostsState');

  @override
  Future<void> _modifyPostsState(PostsState stateModify) {
    return _$_modifyPostsStateAsyncAction
        .run(() => super._modifyPostsState(stateModify));
  }

  final _$listPostsAsyncAction = AsyncAction('_PostsControllerBase.listPosts');

  @override
  Future<void> listPosts({String? cursorID}) {
    return _$listPostsAsyncAction
        .run(() => super.listPosts(cursorID: cursorID));
  }

  final _$_PostsControllerBaseActionController =
      ActionController(name: '_PostsControllerBase');

  @override
  void modifyShimmer(int length) {
    final _$actionInfo = _$_PostsControllerBaseActionController.startAction(
        name: '_PostsControllerBase.modifyShimmer');
    try {
      return super.modifyShimmer(length);
    } finally {
      _$_PostsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
posts: ${posts},
loadingShimmer: ${loadingShimmer}
    ''';
  }
}
