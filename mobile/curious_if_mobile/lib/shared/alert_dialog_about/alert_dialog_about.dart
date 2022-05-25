import 'package:flutter/material.dart';

import '../../core/core.dart';

class AlertDialogAbout extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final String back;
  final List<Widget> children;
  const AlertDialogAbout({
    Key? key,
    required this.onPress,
    required this.children,
    required this.title,
    required this.back,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.hardEdge,
      backgroundColor: AppTheme.colors.backgroundAlertDialog,
      title: Container(
        decoration: BoxDecoration(gradient: AppTheme.gradients.background),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        child: Row(
          children: [
            Flexible(
              child: Text(
                title,
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                AppTheme.colors.backgroundAlertDialog),
            side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: AppTheme.colors.border, width: 1)),
          ),
          child: Text(
            back,
            style: AppTheme.textStyles.textAlertDialog.copyWith(fontSize: 14),
          ),
          onPressed: () => onPress(),
        ),
      ],
    );
  }
}
