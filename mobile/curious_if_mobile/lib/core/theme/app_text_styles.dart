import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../core.dart';

abstract class AppTextStyles {
  TextStyle get textHeadingThree;
  TextStyle get textHeadingTwo;
  TextStyle get textHintFieldInput;
  TextStyle get textFieldInput;
  TextStyle get textButtonInput;
  TextStyle get textBottomNavigation;
  TextStyle get subtitleOpacity;
  TextStyle get subtitleButton;

  TextStyle get titlePost;
  TextStyle get subtitleTextPost;
  TextStyle get titleTextPost;

  /*---------------TEXTSTYLE SETTINGS---------------*/
  TextStyle get textButton;
  TextStyle get textSnackBar;
  TextStyle get textAlertDialog;
  TextStyle get titleAlertDialog;
  TextStyle get appBarTitleSettings;
  TextStyle get bodyCardTitleSettings;
  TextStyle get bodyCardSubtitleSettings;
  TextStyle get bodyButtomTitleSettings;
  TextStyle get bodyTitleSettings;
}

class AppTextStylesDefault implements AppTextStyles {
  @override
  TextStyle get textHintFieldInput => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: AppTheme.colors.textField,
      );
  @override
  TextStyle get textFieldInput => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.colors.text,
      );
  @override
  TextStyle get textButtonInput => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.colors.textButtonApp,
      );
  @override
  TextStyle get textHeadingThree => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppTheme.colors.text,
      );
  @override
  TextStyle get textHeadingTwo => GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: AppTheme.colors.text,
      );
  @override
  TextStyle get textBottomNavigation => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppTheme.colors.text,
      );

  @override
  TextStyle get subtitleOpacity => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.colors.subtitleOpacity,
      );
  @override
  TextStyle get subtitleButton => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppTheme.colors.subtitleButton,
      );

  @override
  TextStyle get titlePost => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppTheme.colors.titlePost,
      );

  @override
  TextStyle get subtitleTextPost => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppTheme.colors.titlePost,
      );

  @override
  TextStyle get titleTextPost => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppTheme.colors.subtitlePost,
      );
  /*---------------TEXTSTYLE SETTINGS---------------*/
  @override
  TextStyle get textButton => GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: AppTheme.colors.textButton,
      );

  @override
  TextStyle get textAlertDialog => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.textSimple,
      );

  @override
  TextStyle get titleAlertDialog => GoogleFonts.montserrat(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: AppTheme.colors.textGradient,
      );

  @override
  TextStyle get textSnackBar => GoogleFonts.inter(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        color: AppTheme.colors.textSnackBar,
      );

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
