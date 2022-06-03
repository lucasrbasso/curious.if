// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpController on _SignUpControllerBase, Store {
  late final _$stateAtom =
      Atom(name: '_SignUpControllerBase.state', context: context);

  @override
  SignUpState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SignUpState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_modifySignUpStateAsyncAction =
      AsyncAction('_SignUpControllerBase._modifySignUpState', context: context);

  @override
  Future<void> _modifySignUpState(SignUpState state) {
    return _$_modifySignUpStateAsyncAction
        .run(() => super._modifySignUpState(state));
  }

  late final _$signUpAsyncAction =
      AsyncAction('_SignUpControllerBase.signUp', context: context);

  @override
  Future<void> signUp({required SignUpModel signUpModel}) {
    return _$signUpAsyncAction
        .run(() => super.signUp(signUpModel: signUpModel));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
