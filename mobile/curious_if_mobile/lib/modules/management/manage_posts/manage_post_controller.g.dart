// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_post_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ManagePostController on _ManagePostControllerBase, Store {
  late final _$stateAtom =
      Atom(name: '_ManagePostControllerBase.state', context: context);

  @override
  ManagePostState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ManagePostState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$postsAtom =
      Atom(name: '_ManagePostControllerBase.posts', context: context);

  @override
  ObservableList<PostManagementModel> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(ObservableList<PostManagementModel> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  late final _$loadingShimmerAtom =
      Atom(name: '_ManagePostControllerBase.loadingShimmer', context: context);

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

  late final _$_modifyManagePostStateAsyncAction = AsyncAction(
      '_ManagePostControllerBase._modifyManagePostState',
      context: context);

  @override
  Future<void> _modifyManagePostState(ManagePostState stateModify) {
    return _$_modifyManagePostStateAsyncAction
        .run(() => super._modifyManagePostState(stateModify));
  }

  late final _$getListPostsUnauthorizedAsyncAction = AsyncAction(
      '_ManagePostControllerBase.getListPostsUnauthorized',
      context: context);

  @override
  Future<void> getListPostsUnauthorized(
      {required String token, required GlobalKey<AnimatedListState> listKey}) {
    return _$getListPostsUnauthorizedAsyncAction.run(
        () => super.getListPostsUnauthorized(token: token, listKey: listKey));
  }

  late final _$onPublishEditAsyncAction =
      AsyncAction('_ManagePostControllerBase.onPublishEdit', context: context);

  @override
  Future<void> onPublishEdit(
      String id, String token, Function onAnimationDeletion, bool isPublished) {
    return _$onPublishEditAsyncAction.run(
        () => super.onPublishEdit(id, token, onAnimationDeletion, isPublished));
  }

  late final _$confirmDismissAsyncAction =
      AsyncAction('_ManagePostControllerBase.confirmDismiss', context: context);

  @override
  Future<bool> confirmDismiss(
      String id, String token, Function onAnimationDeletion, bool isPublished) {
    return _$confirmDismissAsyncAction.run(() =>
        super.confirmDismiss(id, token, onAnimationDeletion, isPublished));
  }

  late final _$patchPostUnauthorizedAsyncAction = AsyncAction(
      '_ManagePostControllerBase.patchPostUnauthorized',
      context: context);

  @override
  Future<void> patchPostUnauthorized(
      {required String token, required String id, required bool isPublished}) {
    return _$patchPostUnauthorizedAsyncAction.run(() => super
        .patchPostUnauthorized(token: token, id: id, isPublished: isPublished));
  }

  late final _$_ManagePostControllerBaseActionController =
      ActionController(name: '_ManagePostControllerBase', context: context);

  @override
  void modifyShimmer(int length) {
    final _$actionInfo = _$_ManagePostControllerBaseActionController
        .startAction(name: '_ManagePostControllerBase.modifyShimmer');
    try {
      return super.modifyShimmer(length);
    } finally {
      _$_ManagePostControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onDismissed(
      int index, BuildContext context, GlobalKey<AnimatedListState> listKey) {
    final _$actionInfo = _$_ManagePostControllerBaseActionController
        .startAction(name: '_ManagePostControllerBase.onDismissed');
    try {
      return super.onDismissed(index, context, listKey);
    } finally {
      _$_ManagePostControllerBaseActionController.endAction(_$actionInfo);
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
