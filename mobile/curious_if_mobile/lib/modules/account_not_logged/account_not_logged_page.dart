import 'package:curious_if_mobile/shared/button_form_input/button_form_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/core.dart';
import '../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';

class AccountNotLoggedPage extends StatefulWidget {
  const AccountNotLoggedPage({Key? key}) : super(key: key);

  @override
  State<AccountNotLoggedPage> createState() => _AccountNotLoggedPageState();
}

class _AccountNotLoggedPageState extends State<AccountNotLoggedPage> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppThemeController().colorStatus,
      sized: false,
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: FittedBox(
                      fit: BoxFit.contain,
                      child: Icon(
                        Icons.account_circle_rounded,
                        color: AppTheme.colors.backgroundButton,
                      )),
                ),
              ),
              Column(
                children: [
                  Text("Opa!", style: AppTheme.textStyles.textHeadingTwo),
                  Text(
                    "Você ainda não fez login!",
                    style: AppTheme.textStyles.subtitleOpacity,
                  ),
                ],
              ),
              ButtonFormInput(
                  onTap: () {
                    Navigator.popAndPushNamed(context, RouterClass.login);
                  },
                  text: "Fazer login"),
              SizedBox(height: 8),
            ],
          ),
        ),
        bottomNavigationBar: BottomTextNavigationBar(
          icon: Icon(Icons.arrow_back, color: AppTheme.colors.text, size: 18),
          onTap: () => Navigator.pop(context),
          text: "Voltar para a home",
        ),
      ),
    );
  }
}
