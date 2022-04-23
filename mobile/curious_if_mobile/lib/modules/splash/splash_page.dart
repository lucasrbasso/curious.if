import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '/core/core.dart';
import '/modules/splash/splash_controller.dart';

class SplashPage extends StatefulWidget {
  final bool redirect;

  const SplashPage({
    Key? key,
    required this.redirect,
  }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final SplashController splashController = SplashController();
  final AppConfigController configController = AppConfigController();

  @override
  void initState() {
    // REDIRECIONAMENTO PARA LOGIN-PAGE
    if (widget.redirect) splashController.redirectSplash(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppThemeController().setThemeMode(ThemeMode.dark);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.colorStatus(),
      sized: false,
      child: Container(
        decoration: BoxDecoration(color: AppTheme.colors.background),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 21.w),
              child: Image.asset(AppTheme.images.logo),
            ),
          ),
        ),
      ),
    );
  }
}
