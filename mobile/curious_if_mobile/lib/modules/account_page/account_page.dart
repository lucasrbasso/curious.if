import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../domain/login/model/user_model.dart';
import '../../core/core.dart';
import '../../shared/app_bar_simple/app_bar_simple.dart';

class AccountPage extends StatelessWidget {
  final UserModel user;
  const AccountPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      appBar: AppBarSimple(user: user, label: "PERFIL", hasBars: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Icon(
                      Icons.account_circle_rounded,
                      color: AppTheme.colors.backgroundButton,
                    )),
              ),
            ),
            SizedBox(height: 10.h),
            Column(
              children: [
                Text("${user.name}", style: AppTheme.textStyles.textHeadingTwo),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
