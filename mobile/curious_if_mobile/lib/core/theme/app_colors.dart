import 'package:flutter/material.dart';

abstract class AppColors {
  Color get background;
  Color get text;
  Color get textField;
  Color get textButtonApp;
  Color get backgroundButton;
  Color get backgroundTextForm;
  Color get backgroundBottomNavigationText;
  Color get subtitleOpacity;
  Color get subtitleButton;
  //COLORS SETTINGS
  Color get border;
  Color get divider;
  Color get backgroundAlertDialogColor;
  Color get backgroundAlertDialog;
  Color get textSimple;
  Color get textButton;
  Color get textGradient;
  Color get textSnackBar;
  Color get appBarIconSettings;
  Color get appBarTitleSettings;
  Color get bodyIconBackgroundSettings;
  Color get bodyIconColorSettings;
  Color get bodyTitleSettings;
  Color get bodyCardSubtitleSettings;
  Color get bodyCardTitleSettings;
  Color get bodySwitchSettings;
  Color get bodyDesactiveSwitchSettings;
  Color get bodyBackgroundSettings;
  Color get bodyDividerSettings;
}

class AppColorsLight implements AppColors {
  @override
  Color get background => const Color(0xFFF0F8FF);
  @override
  Color get text => const Color(0xFF000000);
  @override
  Color get textField => const Color(0xAF000000);
  @override
  Color get textButtonApp => const Color(0xFFFDFDFD);

  @override
  Color get backgroundButton => const Color(0xFF05A678);
  @override
  Color get backgroundTextForm => const Color(0xFFD4D4D4);

  @override
  Color get backgroundBottomNavigationText => const Color(0xFFD4D4D4);

  @override
  Color get subtitleOpacity => const Color(0xFF696969);

  @override
  Color get subtitleButton => const Color(0xFF007A78);

  /*---------------COLORS SETTINGS---------------*/
  @override
  Color get border => const Color(0xFFDCE0E5);

  @override
  Color get divider => const Color(0x33666666);

  @override
  Color get backgroundAlertDialog => const Color(0xFFFFFFFF);

  @override
  Color get backgroundAlertDialogColor => const Color(0xFF4721B4);

  @override
  Color get textButton => const Color(0xFF666666);

  @override
  Color get textSimple => const Color(0xFF666666);

  @override
  Color get textGradient => const Color(0xFFFFFFFF);

  @override
  Color get textSnackBar => const Color(0xFFFFFFFF);

  @override
  Color get appBarIconSettings => const Color(0xFF4F4F4F);

  @override
  Color get appBarTitleSettings => const Color(0xFF4F4F4F);

  @override
  Color get bodyBackgroundSettings => const Color(0xFFF5F5FA);

  @override
  Color get bodyCardSubtitleSettings => const Color(0xFF828282);

  @override
  Color get bodyCardTitleSettings => const Color(0xFF4F4F4F);

  @override
  Color get bodyIconBackgroundSettings => const Color(0xFF585666);

  @override
  Color get bodyIconColorSettings => const Color(0xFFFFFFFF);

  @override
  Color get bodySwitchSettings => const Color(0xFF9B51E0);

  @override
  Color get bodyDesactiveSwitchSettings => const Color(0xFFFEFEFE);

  @override
  Color get bodyTitleSettings => const Color(0xFF333333);

  @override
  Color get bodyDividerSettings => const Color(0xFFE5E5E5);
}

class AppColorsDark implements AppColors {
  @override
  Color get background => const Color(0xFF3E3B47);
  @override
  Color get text => const Color(0xFFF4EDE8);
  @override
  Color get textField => const Color(0xFF666360);
  @override
  Color get textButtonApp => const Color(0xFFFDFDFD);

  @override
  Color get backgroundButton => const Color(0xFF05A678);

  @override
  Color get backgroundTextForm => const Color(0xFF232129);

  @override
  Color get backgroundBottomNavigationText => const Color(0xFF312E38);

  @override
  Color get subtitleOpacity => const Color(0xFF999591);

  @override
  Color get subtitleButton => const Color(0xFF007A78);
/*---------------COLORS SETTINGS---------------*/
  @override
  Color get border => const Color(0xFF5C5C5C);

  @override
  Color get divider => const Color(0x33666666);

  @override
  Color get backgroundAlertDialog => const Color(0xFF333333);

  @override
  Color get backgroundAlertDialogColor => const Color(0xFF4721B4);

  @override
  Color get textGradient => const Color(0xFFFFFFFF);

  @override
  Color get textButton => const Color(0xFFFFFFFF);

  @override
  Color get textSimple => const Color(0xFFFFFFFF);

  @override
  Color get textSnackBar => const Color(0xFFFFFFFF);

  @override
  Color get appBarIconSettings => const Color(0xFFFFFFFF);

  @override
  Color get appBarTitleSettings => const Color(0xFFFFFFFF);

  @override
  Color get bodyBackgroundSettings => const Color(0xFF333333);

  @override
  Color get bodyCardSubtitleSettings => const Color(0xFFE0E0E0);

  @override
  Color get bodyCardTitleSettings => const Color(0xFFF2F2F2);

  @override
  Color get bodyIconBackgroundSettings => const Color(0xFF585666);

  @override
  Color get bodyIconColorSettings => const Color(0xFFFFFFFF);

  @override
  Color get bodySwitchSettings => const Color(0xFF9B51E0);

  @override
  Color get bodyDesactiveSwitchSettings => const Color(0xFFFEFEFE);

  @override
  Color get bodyTitleSettings => const Color(0xFFFFFFFF);

  @override
  Color get bodyDividerSettings => const Color(0xFF4F4F4F);
}
