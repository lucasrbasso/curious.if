import 'package:flutter/material.dart';

import '../../core/core.dart';

class BottomTextNavigationBar extends StatelessWidget {
  final String text;
  final Icon icon;
  final VoidCallback onTap;
  const BottomTextNavigationBar({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 46,
      color: AppTheme.colors.backgroundBottomNavigationText,
      child: TextButton.icon(
        onPressed: () => onTap(),
        icon: icon,
        label: Text(
          text,
          style: AppTheme.textStyles.textBottomNavigation,
        ),
      ),
    );
  }
}
