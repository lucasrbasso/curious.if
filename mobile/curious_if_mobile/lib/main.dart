import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app_widget.dart';

void main() async {
  // INICIA A APLICAÇÃO FLUTTER
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const AppWidget());
}
