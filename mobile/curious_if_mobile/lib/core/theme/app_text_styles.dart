import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../core.dart';

abstract class AppTextStyles {
  TextStyle get textGradient;
  TextStyle get textAppBar;
  TextStyle get textTooltip;
  TextStyle get textSimple;
  TextStyle get textTitle;
  TextStyle get textSubtitle;
  TextStyle get textButton;
  TextStyle get textSubtitleOpacity;
  TextStyle get buttonColor;
  TextStyle get textSelect;
  TextStyle get textSnackBar;
  TextStyle get textAlertDialog;
  TextStyle get textSlidableButton;
  TextStyle get errorTextForm;

  /*---------------TEXTSTYLE SETTINGS---------------*/
  TextStyle get appBarTitleSettings;
  TextStyle get bodyCardTitleSettings;
  TextStyle get bodyCardSubtitleSettings;
  TextStyle get bodyButtomTitleSettings;
  TextStyle get bodyTitleSettings;
  TextStyle get titleAlertDialog;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get textGradient => GoogleFonts.montserrat(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        foreground: Paint()
          ..shader = AppTheme.gradients.textGradient
              .createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
      );

  @override
  TextStyle get textAlertDialog => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.textSimple,
      );

  @override
  TextStyle get errorTextForm => GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.textError,
      );

  @override
  TextStyle get textSimple => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppTheme.colors.textSimple,
      );

  @override
  TextStyle get textTooltip => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      );

  @override
  TextStyle get textSlidableButton => GoogleFonts.inter(
        fontSize: 8.5.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  @override
  TextStyle get textAppBar => GoogleFonts.montserrat(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.textGradient,
      );

  @override
  TextStyle get titleAlertDialog => GoogleFonts.montserrat(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.textGradient,
      );

  @override
  TextStyle get textTitle => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.textTitle,
      );

  @override
  TextStyle get textSubtitle => GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: AppTheme.colors.textSubtitle,
      );

  @override
  TextStyle get textButton => GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: AppTheme.colors.textButton,
      );

  @override
  TextStyle get textSubtitleOpacity => GoogleFonts.inter(
        fontSize: 9.sp,
        fontWeight: FontWeight.w400,
        color: AppTheme.colors.textSubtitleOpacity,
      );

  @override
  TextStyle get buttonColor => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppTheme.colors.textTitle,
      );

  @override
  TextStyle get textSelect => GoogleFonts.inter(
        fontSize: 8.5.sp,
        fontWeight: FontWeight.w600,
        color: AppTheme.colors.textSimple,
      );

  @override
  TextStyle get textSnackBar => GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  /*---------------TEXTSTYLE SETTINGS---------------*/
  @override
  TextStyle get appBarTitleSettings {
    return GoogleFonts.notoSans(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: AppTheme.colors.appBarTitleSettings,
    );
  }

  @override
  TextStyle get bodyButtomTitleSettings {
    return GoogleFonts.notoSans(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.colors.bodyCardTitleSettings,
    );
  }

  @override
  TextStyle get bodyCardSubtitleSettings {
    return GoogleFonts.notoSans(
      fontSize: 10.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.colors.bodyCardSubtitleSettings,
    );
  }

  @override
  TextStyle get bodyCardTitleSettings {
    return GoogleFonts.notoSans(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppTheme.colors.bodyCardTitleSettings,
    );
  }

  @override
  TextStyle get bodyTitleSettings {
    return GoogleFonts.notoSans(
      fontSize: 10.sp,
      fontWeight: FontWeight.w700,
      color: AppTheme.colors.bodyTitleSettings,
    );
  }
}
