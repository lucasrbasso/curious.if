// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$stateAtom = Atom(name: '_LoginControllerBase.state');

  @override
  LoginState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(LoginState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$_modifyLoginStateAsyncAction =
      AsyncAction('_LoginControllerBase._modifyLoginState');

  @override
  Future<void> _modifyLoginState(LoginState state) {
    return _$_modifyLoginStateAsyncAction
        .run(() => super._modifyLoginState(state));
  }

  final _$loginAsyncAction = AsyncAction('_LoginControllerBase.login');

  @override
  Future<void> login({required LoginModel loginModel}) {
    return _$loginAsyncAction.run(() => super.login(loginModel: loginModel));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
