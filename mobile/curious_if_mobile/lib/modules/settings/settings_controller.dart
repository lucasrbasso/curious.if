import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/core.dart';
import '../../i18n/i18n_const.dart';
import 'settings_state.dart';
part 'settings_controller.g.dart';

class SettingsController extends _SettingsControllerBase
    with _$SettingsController {
  SettingsController({AppConfigControllerBase? controllerConfig}) {
    _controllerConfig = controllerConfig ?? AppConfigController();
  }
}

abstract class _SettingsControllerBase with Store {
  late AppConfigControllerBase _controllerConfig;

  @observable
  SettingsState state = SettingsStateEmpty();

  @action
  Future<void> _modifySettingsState(SettingsState stateModify) async =>
      state = stateModify;

  @action
  Future<void> signOutGoogle(Function navigationLogin) async {
    try {
      await _modifySettingsState(SettingsStateLoading());
      await _modifySettingsState(SettingsStateSuccess(
          message: "Você deslogou com sucesso", result: 'isLogin'));
      navigationLogin();
    } catch (e) {
      await _modifySettingsState(SettingsStateFailure(message: e.toString()));
    }
  }

  @action
  Future<void> setLocale(String? locale) async {
    try {
      await _modifySettingsState(SettingsStateLoading());
      final setLocale = await _controllerConfig.setStringLocale(locale);
      await _modifySettingsState(SettingsStateSuccess(
          message: "Tradução modificada coom sucesssso", result: setLocale));
    } catch (e) {
      await _modifySettingsState(SettingsStateFailure(message: e.toString()));
    }
  }

  void navigationLogin(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouterClass.splash,
      (route) => false,
    );
  }

  String get locale => _controllerConfig.locale.languageCode;

  // FUNÇÃO PARA ABRIR O SNACKBAR
  void showSnackBar(BuildContext context, String text, Color color) {
    SnackBar snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTheme.textStyles.textSnackBar,
      ),
      backgroundColor: color,
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void autoRun(BuildContext context) {
    autorun((_) {
      if (state is SettingsStateFailure) {
        String message = (state as SettingsStateFailure).message;
        showSnackBar(context, message, Colors.red);
      } else if (state is SettingsStateSuccess) {
        String message = (state as SettingsStateSuccess).message;
        showSnackBar(context, message, Colors.green);
      }
    });
  }

  void dispose() {}
}
