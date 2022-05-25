import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class BottomNavigationBarHome extends StatefulWidget {
  final Function(int) onTap;
  const BottomNavigationBarHome({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  State<BottomNavigationBarHome> createState() =>
      _BottomNavigationBarHomeState();
}

class _BottomNavigationBarHomeState extends State<BottomNavigationBarHome> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppTheme.colors.backgroundAppBar,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: (index) => widget.onTap(index),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_sharp,
            size: 34,
            color: AppTheme.colors.backgroundButton,
          ),
          label: "Postagens",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.rocket_launch_rounded,
            size: 34,
            color: AppTheme.colors.backgroundButton,
          ),
          label: "Em alta",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            size: 34,
            color: AppTheme.colors.backgroundButton,
          ),
          label: "Pesquisa",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle,
            size: 34,
            color: AppTheme.colors.backgroundButton,
          ),
          label: "Conta",
        ),
      ],
    );
  }
}
