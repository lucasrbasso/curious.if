import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../../domain/login/model/user_model.dart';
import 'pages/create_post_page/create_post_page.dart';
import 'pages/posts_page/posts_page.dart';
import 'widgets/app_bar_home/app_bar_home.dart';
import 'widgets/bottom_navigation_bar_home/bottom_navigation_bar_home.dart';

class HomePage extends StatefulWidget {
  final UserModel? user;
  const HomePage({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexPage = 0;
  late List pages;
  @override
  void initState() {
    pages = [
      PostsPage(),
      PostsPage(),
      PostsPage(),
      PostsPage(),
      CreatePostPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    print(statusBarHeight);
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      appBar: AppBarHome(
        statusBarHeight: statusBarHeight,
        createPost: () {
          indexPage = 4;
          setState(() {});
        },
      ),
      bottomNavigationBar: BottomNavigationBarHome(
        onTap: (index) {
          indexPage = index;
          setState(() {});
        },
      ),
      body: pages[indexPage],
      floatingActionButton: FloatingActionButton(onPressed: () async {
        try {
          await AppThemeController().toggleThemeMode();
        } catch (e) {}
      }),
    );
  }
}
