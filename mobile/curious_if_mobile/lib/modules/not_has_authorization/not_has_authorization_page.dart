import 'package:curious_if_mobile/shared/button_form_input/button_form_input.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/core.dart';
import '../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';

class NotHasAuthorizationPage extends StatelessWidget {
  const NotHasAuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Você não tem autorização suficiente!!!",
                  style: AppTheme.textStyles.subtitleOpacity,
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: BottomTextNavigationBar(
        icon: Icon(Icons.arrow_back, color: AppTheme.colors.text, size: 18),
        onTap: () => Navigator.pop(context),
        text: "Voltar para a home",
      ),
    );
  }
}
