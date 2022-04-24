import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/core.dart';
import '../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';
import 'widgets/form_sign_up/form_sign_up.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppThemeController().colorStatus,
      sized: false,
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            reverse: true,
            children: [
              AnimatedContainer(
                height: isKeyboard ? 20 : 70,
                constraints: BoxConstraints(maxHeight: 5.h),
                duration: const Duration(milliseconds: 150),
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.linear,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Image.asset(AppTheme.images.logo),
              ),
              AnimatedContainer(
                height: isKeyboard ? 35 : 95,
                constraints: BoxConstraints(maxHeight: 5.h * 100.h / 100.w),
                duration: const Duration(milliseconds: 150),
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.linear,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.w),
                child: Column(
                  children: [
                    Text("Crie sua conta",
                        style: AppTheme.textStyles.textHeadingThree),
                    const SizedBox(height: 24),
                    FormSignUpWidget(
                      onSaved: (signUpModel) {
                        print(signUpModel);
                      },
                    ),
                  ],
                ),
              ),
            ].reversed.toList(),
          ),
        ),
        bottomNavigationBar: BottomTextNavigationBar(
          icon: Icon(Icons.arrow_back, color: AppTheme.colors.text, size: 18),
          onTap: () {},
          text: "Voltar para o login",
        ),
      ),
    );
  }
}
