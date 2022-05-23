import 'package:curious_if_mobile/core/routes/verify_roles.dart';
import 'package:curious_if_mobile/modules/create_post_page/create_post_page.dart';
import 'package:curious_if_mobile/modules/home/home_page.dart';
import 'package:curious_if_mobile/modules/login/login_page.dart';
import 'package:curious_if_mobile/modules/sign_up/sign_up_page.dart';
import 'package:flutter/material.dart';
import '../../domain/login/model/user_model.dart';
import '../../modules/account_page/account_page.dart';
import '../../modules/sign_up/sign_up_success/sign_up_success_page.dart';
import '/core/config/app_config_page.dart';
import '/modules/splash/splash_page.dart';

// CLASSE COM TODA REGRA DAS ROTAS DO APLICATIVO
class RouterClass {
  // STRINGS DAS ROTAS
  static const String initial = "/";
  static const String splash = "/splash";
  static const String home = "/home";
  static const String accountNotLogged = "/account-not-logged";
  static const String notHasAuthorization = "/not-has-authorization";
  static const String login = "/login";
  static const String signUp = "/sign-up";
  static const String signUpSuccess = "/sign-up-success";
  static const String explorer = "/explorer";
  static const String search = "/search";
  static const String post = "/post";
  static const String createPost = "/create-post";
  static const String notHasPost = "/not-has-post";
  static const String profile = "/profile";
  static const String config = "/config";
  static const String activities = "/activities";
  static const String delation = "/delation";
  static const String manageRolesAndPermissions =
      "/manage-roles-and-permissions";
  static const String manageNewPosts = "/manage-new-posts";
  static const String menageNewRegistrations = "/manage-new-registrations";

  // FUNÇÃO DE GERAÇÃO DE ROTAS
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    // Map<String, dynamic> arguments = settings.arguments as Map<String, dynamic>;
    // PROCURA A ROTA

    Map<String, dynamic>? arguments;
    UserModel? user;
    if (routeSettings.arguments is Map<String, dynamic>) {
      arguments = routeSettings.arguments as Map<String, dynamic>;
      user = arguments["user"];
    }

    switch (routeSettings.name) {
      case initial:
        return MaterialPageRoute(builder: (_) => const AppConfigPage());

      case splash:
        return MaterialPageRoute(
            builder: (_) => SplashPage(redirect: true, key: UniqueKey()));

      case home:
        UserModel? user = arguments?["user"];
        return MaterialPageRoute(builder: (_) => HomePage(user: user));

      case login:
        String? email = arguments?["email"];
        return MaterialPageRoute(
            builder: (_) => LoginPage(email: email ?? '', key: UniqueKey()));

      case signUp:
        String? email = arguments?["email"];
        String? password = arguments?["password"];
        return MaterialPageRoute(
            builder: (_) => SignUpPage(
                initialEmail: email ?? '', initialPassword: password ?? ''));

      case signUpSuccess:
        String? email = arguments?["email"];
        return MaterialPageRoute(
            builder: (_) =>
                SignUpSuccessPage(email: email ?? '', key: UniqueKey()));
      //TODO: Criar tela de em alta
      case explorer:
        return MaterialPageRoute(builder: (_) => Container());

      //TODO: Criar tela de pesquisa
      case search:
        return MaterialPageRoute(builder: (_) => Container());

      //TODO: Criar tela de uma postagem
      case post:
        return MaterialPageRoute(builder: (_) => Container());

      //TODO: Criar tela de uma postagem
      case createPost:
        return MaterialPageRoute(
          builder: (_) => VerifyRoles.verifyRoleAndUser(
            user,
            VerifyRoles.verifyCanPost(user),
            user == null
                ? Container()
                : CreatePostPage(
                    user: user,
                    onSuccess: () {},
                  ),
          ),
        );

      //TODO: Criar tela de não há postagem
      case notHasPost:
        return MaterialPageRoute(builder: (_) => Container());

      //TODO: Criar tela do profile
      case profile:
        return MaterialPageRoute(
          builder: (_) => VerifyRoles.verifyRoleAndUser(
            user,
            true,
            AccountPage(),
          ),
        );

      //TODO: Criar tela de configurações
      case config:
        return MaterialPageRoute(
          builder: (_) => VerifyRoles.verifyRoleAndUser(
            user,
            true,
            Container(),
          ),
        );

      //TODO: Criar tela de atividades
      case activities:
        return MaterialPageRoute(
          builder: (_) => VerifyRoles.verifyRoleAndUser(
            user,
            true,
            Container(),
          ),
        );

      //TODO: Criar tela de denuncias
      case delation:
        return MaterialPageRoute(
          builder: (_) => VerifyRoles.verifyRoleAndUser(
            user,
            VerifyRoles.verifyAdmin(user) || VerifyRoles.verifyMod(user),
            Container(),
          ),
        );

      //TODO: Criar gerenciar roles e permissoes
      case manageRolesAndPermissions:
        return MaterialPageRoute(
          builder: (_) => VerifyRoles.verifyRoleAndUser(
            user,
            VerifyRoles.verifyAdmin(user),
            Container(),
          ),
        );
      //TODO: Criar tela de gerenciar posts
      case manageNewPosts:
        return MaterialPageRoute(
          builder: (_) => VerifyRoles.verifyRoleAndUser(
            user,
            VerifyRoles.verifyAdmin(user) || VerifyRoles.verifyMod(user),
            Container(),
          ),
        );

      //TODO: Criar tela de gerenciar registros
      case menageNewRegistrations:
        return MaterialPageRoute(
          builder: (_) => VerifyRoles.verifyRoleAndUser(
            user,
            VerifyRoles.verifyAdmin(user) || VerifyRoles.verifyMod(user),
            Container(),
          ),
        );

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
