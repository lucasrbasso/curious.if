import 'package:flutter/material.dart';

abstract class AppColors {
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
