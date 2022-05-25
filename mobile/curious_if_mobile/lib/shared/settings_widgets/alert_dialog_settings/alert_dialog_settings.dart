import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/core.dart';
import '../../../i18n/i18n_const.dart';
import '../cart_text_widget/card_text_widget.dart';

class AlertDialogSettings extends StatelessWidget {
  final VoidCallback yesPress;
  const AlertDialogSettings({
    Key? key,
    required this.yesPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderWidth = 0.3.w;
    double borderRadius = 1.w;
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: AppTheme.colors.backgroundAlertDialog,
      title: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors.backgroundAlertDialogColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: Row(
          children: [
            Flexible(
              child: Text(
                "Informações do usuário",
                style: AppTheme.textStyles.titleAlertDialog,
              ),
            ),
          ],
        ),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      content: Scrollbar(
        isAlwaysShown: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CardTextWidget(
                title: "Nome",
                subtitle: 'user.name',
              ),
              SizedBox(height: 1.h),
              CardTextWidget(
                title: "Email",
                subtitle: 'user.email',
              ),
              SizedBox(height: 1.h),
            ],
          ),
        ),
      ),
      actions: [
        InkWell(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border:
                  Border.all(color: AppTheme.colors.border, width: borderWidth),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 1.h),
            child: Text("Sair", style: AppTheme.textStyles.textButton),
          ),
          onTap: yesPress,
        ),
      ],
    );
  }
}
