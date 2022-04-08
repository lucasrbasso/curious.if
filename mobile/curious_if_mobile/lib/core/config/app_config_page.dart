import '../../i18n/i18n_const.dart';
import '/modules/splash/splash_page.dart';

import '/core/core.dart';
import 'package:flutter/material.dart';

class AppConfigPage extends StatefulWidget {
  const AppConfigPage({
    Key? key,
  }) : super(key: key);

  @override
  _AppConfigPageState createState() => _AppConfigPageState();
}

class _AppConfigPageState extends State<AppConfigPage> {
  //CONTROLADOR COM FUNÇÕES DO TEMA
  final AppConfigController _controllerConfig = AppConfigController();

  Widget body = SplashPage(
    redirect: false,
    key: UniqueKey(),
  );

  @override
  void initState() {
    // INICIALIZA TODAS AS CONFIGURAÇÕES DO APP
    _controllerConfig.initialConfiguration().then((value) {
      if (value) {
        body = SplashPage(
          redirect: true,
          key: UniqueKey(),
        );
      } else {
        body = Material(
          child: Center(
            child: Text(
              I18nConst.erroConfigApp,
              textDirection: TextDirection.ltr,
            ),
          ),
        );
      }
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return body;
  }
}
