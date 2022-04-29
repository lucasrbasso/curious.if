import 'dart:io';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'package:image/image.dart' as img;

/// Take a screenshotボタンを押すとクリップボードに便利コマンドがコピーされる
Future<void> onScreenshot(
  BuildContext context,
  DeviceScreenshot screenshot,
) async {
  final isFrameVisible = context.read<DevicePreviewStore>().data.isFrameVisible;

  final timestamp = DateTime.now();
  final tempDir = await getTemporaryDirectory();
  final file = await File(
          '${tempDir.path}/${screenshot.device.name.replaceAll(" ", "")}_${timestamp.toString().replaceAll(RegExp(r"[^a-zA-Z0-9]"), "")}.png')
      .create();
  // フレームがあるときはそのまま書き込む
  print(
      '${tempDir.path}/${screenshot.device.name.replaceAll(" ", "")}_${timestamp.toString().replaceAll(RegExp(r"[^a-zA-Z0-9]"), "")}.png');
  if (isFrameVisible) {
    file.writeAsBytesSync(screenshot.bytes);
  } else {
    final rawImage = img.decodePng(screenshot.bytes);
    final resizedImage = img.copyResize(
      // ignore: avoid-non-null-assertion
      rawImage!,
      width: (screenshot.device.screenSize.width * screenshot.device.pixelRatio)
          .toInt(),
      height:
          (screenshot.device.screenSize.height * screenshot.device.pixelRatio)
              .toInt(),
    );
    file.writeAsBytesSync(img.encodePng(resizedImage));
  }
  await Clipboard.setData(
    ClipboardData(text: 'adb shell\n mv ${file.parent.path}/*.png ~'),
  );
}
