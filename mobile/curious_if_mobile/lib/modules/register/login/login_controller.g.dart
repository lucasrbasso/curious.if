// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginController on _LoginControllerBase, Store {
  late final _$stateAtom =
      Atom(name: '_LoginControllerBase.state', context: context);

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

  late final _$_modifyLoginStateAsyncAction =
      AsyncAction('_LoginControllerBase._modifyLoginState', context: context);

  @override
  Future<void> _modifyLoginState(LoginState state) {
    return _$_modifyLoginStateAsyncAction
        .run(() => super._modifyLoginState(state));
  }

  late final _$loginAsyncAction =
      AsyncAction('_LoginControllerBase.login', context: context);

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
