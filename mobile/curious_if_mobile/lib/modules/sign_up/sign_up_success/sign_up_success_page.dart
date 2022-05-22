import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/core.dart';
import '../../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';
import '../../../shared/button_form_input/button_form_input.dart';
import 'sign_up_success_controller.dart';

class SignUpSuccessPage extends StatelessWidget {
  final String email;
  const SignUpSuccessPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpSuccessController _controller = SignUpSuccessController();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppThemeController().colorStatus,
      sized: false,
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 11.w),
              child: Column(
                children: [
                  SizedBox(height: 17.5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: Image.asset(AppTheme.images.checkIcon,
                        fit: BoxFit.fitWidth),
                  ),
                  SizedBox(height: 10.h),
                  Column(
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            "Cadastro concluído",
                            style: AppTheme.textStyles.textHeadingTwo,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: Text(
                          "Aguarde até que um moderador aprove seu cadastro",
                          style: AppTheme.textStyles.subtitleOpacity,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  ButtonFormInput(
                    text: "Saquei!",
                    onTap: () => _controller.navigationLogin(context, email),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomTextNavigationBar(
          icon: Icon(Icons.arrow_back, color: AppTheme.colors.text, size: 18),
          onTap: () => Navigator.pop(context),
          text: "Voltar para o cadastro",
        ),
      ),
    );
  }
}
