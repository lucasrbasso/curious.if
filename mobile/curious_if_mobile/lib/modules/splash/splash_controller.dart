import 'package:flutter/material.dart';
import '/core/core.dart';

class SplashController {
  // FUNÇÃO PARA REDIRECIONAR A SPLASH PARA LOGIN PAGE OU PARA NOTEPAGE
  void redirectSplash(BuildContext context) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouterClass.login,
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print(e);
      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushNamedAndRemoveUntil(
          context, 'RouterClass.login', (Route<dynamic> route) => false);
    }
  }
}
