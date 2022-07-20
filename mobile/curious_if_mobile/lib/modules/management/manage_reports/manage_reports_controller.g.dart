// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_reports_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ManageReportsController on _ManageReportsControllerBase, Store {
  late final _$stateAtom =
      Atom(name: '_ManageReportsControllerBase.state', context: context);

  @override
  ManageReportsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ManageReportsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$reportsAtom =
      Atom(name: '_ManageReportsControllerBase.reports', context: context);

  @override
  ObservableList<GetReport> get reports {
    _$reportsAtom.reportRead();
    return super.reports;
  }

  @override
  set reports(ObservableList<GetReport> value) {
    _$reportsAtom.reportWrite(value, super.reports, () {
      super.reports = value;
    });
  }

  late final _$loadingShimmerAtom = Atom(
      name: '_ManageReportsControllerBase.loadingShimmer', context: context);

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

  late final _$_modifyManageReportsStateAsyncAction = AsyncAction(
      '_ManageReportsControllerBase._modifyManageReportsState',
      context: context);

  @override
  Future<void> _modifyManageReportsState(ManageReportsState stateModify) {
    return _$_modifyManageReportsStateAsyncAction
        .run(() => super._modifyManageReportsState(stateModify));
  }

  late final _$getListReportsAsyncAction = AsyncAction(
      '_ManageReportsControllerBase.getListReports',
      context: context);

  @override
  Future<void> getListReports(
      {required String token, required GlobalKey<AnimatedListState> listKey}) {
    return _$getListReportsAsyncAction
        .run(() => super.getListReports(token: token, listKey: listKey));
  }

  late final _$onPublishEditAsyncAction = AsyncAction(
      '_ManageReportsControllerBase.onPublishEdit',
      context: context);

  @override
  Future<void> onPublishEdit(String id, String token,
      Function onAnimationDeletion, String postId, bool isPost, bool isAccept) {
    return _$onPublishEditAsyncAction.run(() => super.onPublishEdit(
        id, token, onAnimationDeletion, postId, isPost, isAccept));
  }

  late final _$confirmDismissAsyncAction = AsyncAction(
      '_ManageReportsControllerBase.confirmDismiss',
      context: context);

  @override
  Future<bool> confirmDismiss(String id, String token,
      Function onAnimationDeletion, String postId, bool isPost, bool isAccept) {
    return _$confirmDismissAsyncAction.run(() => super.confirmDismiss(
        id, token, onAnimationDeletion, postId, isPost, isAccept));
  }

  late final _$deleteOrAcceptReportAsyncAction = AsyncAction(
      '_ManageReportsControllerBase.deleteOrAcceptReport',
      context: context);

  @override
  Future<void> deleteOrAcceptReport(
      {required String token,
      required String id,
      required String postId,
      required bool isPost,
      required bool isAccept}) {
    return _$deleteOrAcceptReportAsyncAction.run(() => super
        .deleteOrAcceptReport(
            token: token,
            id: id,
            postId: postId,
            isPost: isPost,
            isAccept: isAccept));
  }

  late final _$_ManageReportsControllerBaseActionController =
      ActionController(name: '_ManageReportsControllerBase', context: context);

  @override
  void modifyShimmer(int length) {
    final _$actionInfo = _$_ManageReportsControllerBaseActionController
        .startAction(name: '_ManageReportsControllerBase.modifyShimmer');
    try {
      return super.modifyShimmer(length);
    } finally {
      _$_ManageReportsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onDismissed(
      int index, BuildContext context, GlobalKey<AnimatedListState> listKey) {
    final _$actionInfo = _$_ManageReportsControllerBaseActionController
        .startAction(name: '_ManageReportsControllerBase.onDismissed');
    try {
      return super.onDismissed(index, context, listKey);
    } finally {
      _$_ManageReportsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
reports: ${reports},
loadingShimmer: ${loadingShimmer}
    ''';
  }
}
