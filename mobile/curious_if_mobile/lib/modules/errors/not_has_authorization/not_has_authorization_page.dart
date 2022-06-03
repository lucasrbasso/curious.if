import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/core.dart';
import '../../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';

class NotHasAuthorizationPage extends StatefulWidget {
  const NotHasAuthorizationPage({Key? key}) : super(key: key);

  @override
  State<NotHasAuthorizationPage> createState() =>
      _NotHasAuthorizationPageState();
}

class _NotHasAuthorizationPageState extends State<NotHasAuthorizationPage> {
  late int numberCat;
  @override
  void initState() {
    numberCat = Random().nextInt(4);
    super.initState();
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Image.asset(AppTheme.images.cat(numberCat)),
                ),
              ),
              SizedBox(height: 10.h),
              Column(
                children: [
                  Text("Opa!", style: AppTheme.textStyles.textHeadingTwo),
                  Text(
                    "Você não tem autorização suficiente!!!",
                    style: AppTheme.textStyles.subtitleOpacity,
                  ),
                ],
              ),
              const SizedBox(height: 8),
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
