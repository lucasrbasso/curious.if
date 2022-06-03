import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/core.dart';

class AppBarHome extends StatelessWidget with PreferredSizeWidget {
  final double statusBarHeight;
  final Function createPost;
  const AppBarHome({
    Key? key,
    required this.statusBarHeight,
    required this.createPost,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(statusBarHeight / 2 + 4.h);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppThemeController().colorStatus,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: AppTheme.colors.backgroundAppBar,
        padding: EdgeInsets.only(top: statusBarHeight / 2, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppTheme.images.logoApp,
              height: 30,
            ),
            Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () => createPost(),
                    icon: Icon(
                      Icons.add_box,
                      color: AppTheme.colors.backgroundButton,
                    ),
                    iconSize: 28,
                    splashRadius: 24,
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none,
                      color: AppTheme.colors.backgroundButton,
                    ),
                    iconSize: 28,
                    splashRadius: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
