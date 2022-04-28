import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../domain/login/model/user_model.dart';
import '../../domain/post/model/post_model.dart';
import '../../domain/post/repository/post_repository.dart';
import '../../domain/post/usecase/post_usecase.dart';
import 'pages/posts_page/posts_page.dart';
import 'widgets/app_bar_home/app_bar_home.dart';
import 'widgets/bottom_navigation_bar_home/bottom_navigation_bar_home.dart';

class HomePage extends StatefulWidget {
  final UserModel user;
  const HomePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    print(statusBarHeight);
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      appBar: AppBarHome(statusBarHeight: statusBarHeight),
      bottomNavigationBar: BottomNavigationBarHome(),
      body: PostsPage(),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        try {
          await AppThemeController().toggleThemeMode();
        } catch (e) {}
      }),
    );
  }
}
