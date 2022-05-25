import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/app_widget.dart';
import 'core/services/device_screenshot_function.dart';

void main() async {
  // INICIA A APLICAÇÃO FLUTTER
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(DevicePreview(
    tools: const [
      ...DevicePreview.defaultTools,
      DevicePreviewScreenshot(
        onScreenshot: onScreenshot,
        multipleScreenshots: true,
      ),
    ],
    enabled: false,
    builder: (context) => AppWidget(),
  ));
}
