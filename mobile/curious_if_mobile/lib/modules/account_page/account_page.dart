import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../domain/login/model/user_model.dart';
import '../../core/core.dart';
import 'widgets/widget_form/widget_form.dart';

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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: AppThemeController().colorStatus,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.bars,
              ),
              padding: EdgeInsets.zero,
              tooltip: "Opções",
              splashRadius: 24,
              iconSize: 22,
              color: AppTheme.colors.backgroundButton,
              onPressed: () {
                Widget sheet = WidgetForm(key: UniqueKey(), user: user);
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: sheet,
                    );
                  },
                );
              },
            ),
          ),
        ],
        leading: Padding(
          padding: EdgeInsets.only(left: 4),
          child: IconButton(
            icon: const FaIcon(FontAwesomeIcons.arrowLeft),
            tooltip: "Voltar",
            padding: EdgeInsets.zero,
            splashRadius: 24,
            iconSize: 22,
            color: AppTheme.colors.backgroundButton,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
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
