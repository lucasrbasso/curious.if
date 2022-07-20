import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../domain/login/model/user_model.dart';
import '../../core/core.dart';
import '../../shared/app_bar_simple/app_bar_simple.dart';
import 'account_controller.dart';

class AccountPage extends StatefulWidget {
  final UserModel user;
  const AccountPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late AccountController controller;

  @override
  void initState() {
    controller = AccountController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return WillPopScope(
      onWillPop: () async {
        print(controller.posts);
        Navigator.of(context, rootNavigator: true)
            .pop([controller.posts, controller.subtractPosts]);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        appBar: AppBarSimple(
            user: widget.user,
            label: "PERFIL",
            hasBars: true,
            subtractPosts: (post) {
              controller.addPostsSubtract(post);
            },
            addPost: (post) {
              print(post);
              controller.addPosts(post);
            }),
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
                  Text("${widget.user.name}",
                      style: AppTheme.textStyles.textHeadingTwo),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
