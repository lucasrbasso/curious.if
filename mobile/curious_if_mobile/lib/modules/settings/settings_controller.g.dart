// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SettingsController on _SettingsControllerBase, Store {
  late final _$stateAtom =
      Atom(name: '_SettingsControllerBase.state', context: context);

  @override
  SettingsState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(SettingsState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$_modifySettingsStateAsyncAction = AsyncAction(
      '_SettingsControllerBase._modifySettingsState',
      context: context);

  @override
  Future<void> _modifySettingsState(SettingsState stateModify) {
    return _$_modifySettingsStateAsyncAction
        .run(() => super._modifySettingsState(stateModify));
  }

  late final _$signOutGoogleAsyncAction =
      AsyncAction('_SettingsControllerBase.signOutGoogle', context: context);

  @override
  Future<void> signOutGoogle(Function navigationLogin) {
    return _$signOutGoogleAsyncAction
        .run(() => super.signOutGoogle(navigationLogin));
  }

  late final _$setLocaleAsyncAction =
      AsyncAction('_SettingsControllerBase.setLocale', context: context);

  @override
  Future<void> setLocale(String? locale) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(locale));
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
