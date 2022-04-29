import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';

class AppTheme {
  static AppColors get colors {
    AppThemeController themeModeContext = AppThemeController();
    bool isDarkMode = themeModeContext.brightness == Brightness.dark;

    if (!isDarkMode) {
      return AppColorsLight();
    } else {
      return AppColorsDark();
    }
  }

  static AppTextStyles get textStyles => AppTextStylesDefault();
  static AppImages get images {
    AppThemeController themeModeContext = AppThemeController();
    bool isDarkMode = themeModeContext.brightness == Brightness.dark;
    if (!isDarkMode) {
      return AppImagesLight();
    } else {
      return AppImagesDark();
    }
  }

  static AppGradients get gradients {
    AppThemeController themeModeContext = AppThemeController();
    bool isDarkMode = themeModeContext.brightness == Brightness.dark;
    if (!isDarkMode) {
      return AppGradientsLight();
    } else {
      return AppGradientsDark();
    }
  }
}
