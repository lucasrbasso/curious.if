import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/core.dart';

class ButtonIconText extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() onTap;
  const ButtonIconText({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Ink(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20.w),
                  Icon(
                    icon,
                    color: AppTheme.colors.backgroundButton,
                    size: 28,
                  ),
                  const SizedBox(width: 28),
                  Text(label,
                      style: AppTheme.textStyles.subtitleHeadingThree,
                      textAlign: TextAlign.left),
                  // Expanded(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(label,
                  //           style: AppTheme.textStyles.subtitleHeadingThree,
                  //           textAlign: TextAlign.center),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(width: 20.w),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
