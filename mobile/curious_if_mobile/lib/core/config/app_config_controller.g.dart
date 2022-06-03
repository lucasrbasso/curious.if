// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppConfigController on AppConfigControllerBase, Store {
  Computed<Locale>? _$localeComputed;

  @override
  Locale get locale =>
      (_$localeComputed ??= Computed<Locale>(() => super.locale,
              name: 'AppConfigControllerBase.locale'))
          .value;
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state,
              name: 'AppConfigControllerBase.state'))
          .value;

  late final _$_localeFutureAtom =
      Atom(name: 'AppConfigControllerBase._localeFuture', context: context);

  @override
  ObservableFuture<Locale>? get _localeFuture {
    _$_localeFutureAtom.reportRead();
    return super._localeFuture;
  }

  @override
  set _localeFuture(ObservableFuture<Locale>? value) {
    _$_localeFutureAtom.reportWrite(value, super._localeFuture, () {
      super._localeFuture = value;
    });
  }

  late final _$_localeAtom =
      Atom(name: 'AppConfigControllerBase._locale', context: context);

  @override
  Locale get _locale {
    _$_localeAtom.reportRead();
    return super._locale;
  }

  @override
  set _locale(Locale value) {
    _$_localeAtom.reportWrite(value, super._locale, () {
      super._locale = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: 'AppConfigControllerBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$setLocaleAsyncAction =
      AsyncAction('AppConfigControllerBase.setLocale', context: context);

  @override
  Future<Locale> setLocale(Locale locale) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(locale));
  }

  late final _$setStringLocaleAsyncAction =
      AsyncAction('AppConfigControllerBase.setStringLocale', context: context);

  @override
  Future<Locale> setStringLocale(String? locale) {
    return _$setStringLocaleAsyncAction
        .run(() => super.setStringLocale(locale));
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
locale: ${locale},
state: ${state}
    ''';
  }
}
