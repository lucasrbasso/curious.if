import 'package:curious_if_mobile/modules/login/login_page.dart';
import 'package:curious_if_mobile/modules/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import '../../modules/sign_up/sign_up_success/sign_up_success_page.dart';
import '/core/config/app_config_page.dart';
import '/modules/splash/splash_page.dart';

// CLASSE COM TODA REGRA DAS ROTAS DO APLICATIVO
class RouterClass {
  // STRINGS DAS ROTAS
  static const String initial = "/";
  static const String splash = "/splash";
  static const String signUp = "/sign-up";
  static const String signUpSuccess = "/sign-up-success";
  static const String login = "/login";
  static const String home = "/home";
  static const String perfil = "/perfil";

  // FUNÇÃO DE GERAÇÃO DE ROTAS
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    // Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
    // PROCURA A ROTA

    switch (routeSettings.name) {
      // ROTA DA SPLASH
      case splash:
        return MaterialPageRoute(
            builder: (_) => SplashPage(redirect: true, key: UniqueKey()));

      // ROTA COM INICIAL DE CONFIGURAÇÕES
      case initial:
        return MaterialPageRoute(builder: (_) => const AppConfigPage());

      // ROTA COM CADASTRO
      case signUp:
        Map<String, dynamic>? arguments;
        if (routeSettings.arguments is Map<String, dynamic>) {
          arguments = routeSettings.arguments as Map<String, dynamic>;
        }
        String? email = arguments?["email"];
        String? password = arguments?["password"];
        return MaterialPageRoute(
            builder: (_) => SignUpPage(
                initialEmail: email ?? '', initialPassword: password ?? ''));

      // ROTA DA CADASTRO SUCESSO
      case signUpSuccess:
        Map<String, dynamic>? arguments;
        if (routeSettings.arguments is Map<String, dynamic>) {
          arguments = routeSettings.arguments as Map<String, dynamic>;
        }
        String? email = arguments?["email"];
        return MaterialPageRoute(
            builder: (_) =>
                SignUpSuccessPage(email: email ?? '', key: UniqueKey()));

      // ROTA DA LOGIN
      case login:
        Map<String, dynamic>? arguments;
        if (routeSettings.arguments is Map<String, dynamic>) {
          arguments = routeSettings.arguments as Map<String, dynamic>;
        }
        String? email = arguments?["email"];
        return MaterialPageRoute(
            builder: (_) => LoginPage(email: email ?? '', key: UniqueKey()));

      // ROTA CASO NÃO ACHE ROTA
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text("Erro ao achar a rota ${routeSettings.name}")),
          ),
        );
    }
  }
}
