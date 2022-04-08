import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_theme_controller.g.dart';

class AppThemeController extends _AppThemeControllerBase
    with _$AppThemeController {
  static final AppThemeController _instance = AppThemeController._internal();

  // passes the instantiation to the _instance object
  factory AppThemeController() => _instance;

  //initialize variables in here
  AppThemeController._internal() {
    _themeMode = null;
  }
}

abstract class _AppThemeControllerBase with Store {
  // TEMA ATUAL DO APLICATIVO (É OBSERVADO PELO MOBX)
  @observable
  ThemeMode? _themeMode;
  @observable
  Brightness? _brightness;
  @observable
  String? errorMessage;

  // QUANDO O TEMA É ALTERADO ELE INFORMA TODOS OS OBSERVERS EXTERNOS
  @computed
  ThemeMode get themeMode => _themeMode ?? ThemeMode.light;
// QUANDO O TEMA É ALTERADO ELE INFORMA TODOS OS OBSERVERS EXTERNOS
  @computed
  Brightness get brightness => _brightness ?? Brightness.light;

  @computed
  bool get isDarkMode => brightness != Brightness.light;

  @action
  void setBrightness(Brightness? brightness) => _brightness = brightness;

  void reConfigBrightnessWhenModifyTheme(ThemeMode themeModeModify) {
    if (themeModeModify == ThemeMode.system) {
      setBrightness(WidgetsBinding.instance!.window.platformBrightness);
    } else if (themeModeModify == ThemeMode.dark) {
      setBrightness(Brightness.dark);
    } else {
      setBrightness(Brightness.light);
    }
  }

  // SETA O TEMA NOVO QUANDO O USUARIO MUDAR
  // CASO TENHA ALGUM PROBLEMA SETA O TEMA COMO LIGHT
  @action
  Future<bool> setThemeMode(ThemeMode? themeModeModify) async {
    try {
      await saveThemeMode(themeModeModify ?? themeMode);
      reConfigBrightnessWhenModifyTheme(themeModeModify ?? themeMode);
      return true;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }

  // ALTERA O TEMA SALVO NO SHARED PREFERENCES E MUDA O THEME NO CONTROLLER
  Future<void> saveThemeMode(ThemeMode themeModeModify) async {
    try {
      final SharedPreferences instance = await SharedPreferences.getInstance();
      await instance.setString("themeMode", themeModeModify.index.toString());
      _themeMode = themeModeModify;
    } catch (e) {
      rethrow;
    }
  }

  // PEGA O TEMA CASO EXISTA NO SHARED PREFERENCES
  Future<bool> currentThemeMode() async {
    try {
      late bool result;
      final SharedPreferences instance = await SharedPreferences.getInstance();
      if (instance.containsKey("themeMode")) {
        int index = int.parse(instance.get("themeMode") as String);
        if (index == ThemeMode.dark.index) {
          result = await setThemeMode(ThemeMode.dark);
        } else if (index == ThemeMode.light.index) {
          result = await setThemeMode(ThemeMode.light);
        } else {
          result = await setThemeMode(ThemeMode.system);
        }
      } else {
        result = await setThemeMode(null);
      }
      return result;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    }
  }

  void listenBrightnessSystem() {
    SingletonFlutterWindow? window = WidgetsBinding.instance?.window;
    window?.onPlatformBrightnessChanged = () {
      WidgetsBinding.instance?.handlePlatformBrightnessChanged();
      Brightness brightness = window.platformBrightness;
      if (themeMode == ThemeMode.system) setBrightness(brightness);
    };
  }
}
