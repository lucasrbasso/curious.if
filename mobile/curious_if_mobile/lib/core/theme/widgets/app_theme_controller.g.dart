// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppThemeController on _AppThemeControllerBase, Store {
  Computed<ThemeMode>? _$themeModeComputed;

  @override
  ThemeMode get themeMode =>
      (_$themeModeComputed ??= Computed<ThemeMode>(() => super.themeMode,
              name: '_AppThemeControllerBase.themeMode'))
          .value;
  Computed<Brightness>? _$brightnessComputed;

  @override
  Brightness get brightness =>
      (_$brightnessComputed ??= Computed<Brightness>(() => super.brightness,
              name: '_AppThemeControllerBase.brightness'))
          .value;
  Computed<bool>? _$isDarkModeComputed;

  @override
  bool get isDarkMode =>
      (_$isDarkModeComputed ??= Computed<bool>(() => super.isDarkMode,
              name: '_AppThemeControllerBase.isDarkMode'))
          .value;
  Computed<SystemUiOverlayStyle>? _$colorStatusComputed;

  @override
  SystemUiOverlayStyle get colorStatus => (_$colorStatusComputed ??=
          Computed<SystemUiOverlayStyle>(() => super.colorStatus,
              name: '_AppThemeControllerBase.colorStatus'))
      .value;

  late final _$_themeModeAtom =
      Atom(name: '_AppThemeControllerBase._themeMode', context: context);

  @override
  ThemeMode? get _themeMode {
    _$_themeModeAtom.reportRead();
    return super._themeMode;
  }

  @override
  set _themeMode(ThemeMode? value) {
    _$_themeModeAtom.reportWrite(value, super._themeMode, () {
      super._themeMode = value;
    });
  }

  late final _$_brightnessAtom =
      Atom(name: '_AppThemeControllerBase._brightness', context: context);

  @override
  Brightness? get _brightness {
    _$_brightnessAtom.reportRead();
    return super._brightness;
  }

  @override
  set _brightness(Brightness? value) {
    _$_brightnessAtom.reportWrite(value, super._brightness, () {
      super._brightness = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_AppThemeControllerBase.errorMessage', context: context);

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

  late final _$toggleThemeModeAsyncAction =
      AsyncAction('_AppThemeControllerBase.toggleThemeMode', context: context);

  @override
  Future<void> toggleThemeMode() {
    return _$toggleThemeModeAsyncAction.run(() => super.toggleThemeMode());
  }

  late final _$setThemeModeAsyncAction =
      AsyncAction('_AppThemeControllerBase.setThemeMode', context: context);

  @override
  Future<bool> setThemeMode(ThemeMode? themeModeModify) {
    return _$setThemeModeAsyncAction
        .run(() => super.setThemeMode(themeModeModify));
  }

  late final _$_AppThemeControllerBaseActionController =
      ActionController(name: '_AppThemeControllerBase', context: context);

  @override
  void setBrightness(Brightness? brightness) {
    final _$actionInfo = _$_AppThemeControllerBaseActionController.startAction(
        name: '_AppThemeControllerBase.setBrightness');
    try {
      return super.setBrightness(brightness);
    } finally {
      _$_AppThemeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
themeMode: ${themeMode},
brightness: ${brightness},
isDarkMode: ${isDarkMode},
colorStatus: ${colorStatus}
    ''';
  }
}
