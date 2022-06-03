// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ManageUserController on _ManageUserControllerBase, Store {
  late final _$stateAtom =
      Atom(name: '_ManageUserControllerBase.state', context: context);

  @override
  ManageUserState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(ManageUserState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$usersAtom =
      Atom(name: '_ManageUserControllerBase.users', context: context);

  @override
  ObservableList<UserManagementModel> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<UserManagementModel> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$loadingShimmerAtom =
      Atom(name: '_ManageUserControllerBase.loadingShimmer', context: context);

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

  late final _$_modifyManageUserStateAsyncAction = AsyncAction(
      '_ManageUserControllerBase._modifyManageUserState',
      context: context);

  @override
  Future<void> _modifyManageUserState(ManageUserState stateModify) {
    return _$_modifyManageUserStateAsyncAction
        .run(() => super._modifyManageUserState(stateModify));
  }

  late final _$getListUsersAsyncAction =
      AsyncAction('_ManageUserControllerBase.getListUsers', context: context);

  @override
  Future<void> getListUsers({required String token}) {
    return _$getListUsersAsyncAction
        .run(() => super.getListUsers(token: token));
  }

  late final _$_ManageUserControllerBaseActionController =
      ActionController(name: '_ManageUserControllerBase', context: context);

  @override
  void modifyShimmer(int length) {
    final _$actionInfo = _$_ManageUserControllerBaseActionController
        .startAction(name: '_ManageUserControllerBase.modifyShimmer');
    try {
      return super.modifyShimmer(length);
    } finally {
      _$_ManageUserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state},
users: ${users},
loadingShimmer: ${loadingShimmer}
    ''';
  }
}
