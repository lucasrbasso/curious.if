import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/core.dart';
import '../text_form_custom/text_form_custom.dart';

class CardTextWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Color? colorText;
  final bool column;
  final IconData? icon;
  final TextAlign textAlign;
  const CardTextWidget({
    Key? key,
    required this.title,
    this.subtitle,
    this.colorText,
    this.column = true,
    this.icon,
    this.textAlign = TextAlign.left,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (subtitle != null || colorText != null) {
      List<Widget> children = [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FaIcon(icon, color: AppTheme.colors.textSimple),
          ),
        Text(
          title,
          style: AppTheme.textStyles.textAlertDialog,
        ),
        if (!column) Container(width: 2.w),
        if (colorText != null)
          Container(
            color: colorText,
            height: 3.h,
            width: 40.w,
          ),
        if (subtitle != null)
          TextFormCustom(
              text: subtitle!,
              disableForm: true,
              flexible: !column,
              textAlign: textAlign),
      ];

      return column
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            );
    }
    return Container();
  }
}
