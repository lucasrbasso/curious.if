import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core.dart';

class AppTheme {
  static AppColors get colors {
    AppThemeController controllerTheme = AppThemeController();
    ThemeMode themeModeContext = controllerTheme.themeMode;
    if (themeModeContext != ThemeMode.dark) {
      return AppColorsLight();
    } else {
      return AppColorsDark();
    }
  }

  static AppTextStyles get textStyles => AppTextStylesDefault();
  static AppImages get images {
    AppThemeController controllerTheme = AppThemeController();
    ThemeMode themeModeContext = controllerTheme.themeMode;
    if (themeModeContext != ThemeMode.dark) {
      return AppImagesLight();
    } else {
      return AppImagesDark();
    }
  }

  static AppGradients get gradients {
    AppThemeController controllerTheme = AppThemeController();
    ThemeMode themeModeContext = controllerTheme.themeMode;
    if (themeModeContext != ThemeMode.dark) {
      return AppGradientsLight();
    } else {
      return AppGradientsDark();
    }
  }

  static SystemUiOverlayStyle colorStatus({bool isWhite = false}) {
    AppThemeController themeModeContext = AppThemeController();
    if (themeModeContext.themeMode == ThemeMode.dark && !isWhite) {
      isWhite = true;
    }
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // cor da barra superior
      statusBarIconBrightness: isWhite
          ? Brightness.light
          : Brightness.dark, // ícones da barra superior
      statusBarBrightness: isWhite ? Brightness.dark : Brightness.light,
    );
  }
}
