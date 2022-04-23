import 'package:flutter/material.dart';
import '/core/core.dart';

class SplashController {
  SplashController() {}

  // FUNÇÃO PARA REDIRECIONAR A SPLASH PARA LOGIN PAGE OU PARA NOTEPAGE
  void redirectSplash(BuildContext context) async {
    try {
      await Future.delayed(const Duration(seconds: 300));
      Navigator.pushNamedAndRemoveUntil(
        context,
        'RouterClass.notes',
        (Route<dynamic> route) => false,
        arguments: 'user',
      );
    } catch (e) {
      await Future.delayed(const Duration(seconds: 300));
      Navigator.pushNamedAndRemoveUntil(
          context, 'RouterClass.login', (Route<dynamic> route) => false);
    }
  }
}
