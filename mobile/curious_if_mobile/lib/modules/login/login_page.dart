import 'package:curious_if_mobile/domain/login/model/login_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/core.dart';
import '../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';
import 'login_controller.dart';
import 'widgets/form_login/form_login.dart';

class LoginPage extends StatefulWidget {
  final String email;
  const LoginPage({
    Key? key,
    this.email = '',
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController _controller;
  @override
  void initState() {
    _controller = LoginController();
    _controller.autoRun(context);
    super.initState();
  }

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
                constraints: BoxConstraints(maxHeight: 7.h),
                duration: const Duration(milliseconds: 150),
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.linear,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Image.asset(AppTheme.images.logo),
              ),
              AnimatedContainer(
                height: isKeyboard ? 32 : 95,
                constraints: BoxConstraints(maxHeight: 5.h * 100.h / 100.w),
                duration: const Duration(milliseconds: 150),
                // Provide an optional curve to make the animation feel smoother.
                curve: Curves.linear,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.w),
                child: Column(
                  children: [
                    Text("Login", style: AppTheme.textStyles.textHeadingThree),
                    AnimatedContainer(
                      height: isKeyboard ? 24 : 48,
                      constraints:
                          BoxConstraints(maxHeight: 5.h * 100.h / 100.w),
                      duration: const Duration(milliseconds: 150),
                      // Provide an optional curve to make the animation feel smoother.
                      curve: Curves.linear,
                    ),
                    FormLoginWidget(
                      initialEmail: widget.email,
                      onSaved: (loginMap) async => await _controller.login(
                          loginModel: LoginModel.fromMap(loginMap)),
                    ),
                  ],
                ),
              ),
            ].reversed.toList(),
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
