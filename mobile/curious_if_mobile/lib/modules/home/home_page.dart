import 'package:curious_if_mobile/core/routes/verify_roles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';
import '../../domain/login/model/user_model.dart';
import '../../domain/post/model/post_model.dart';
import 'pages/explorer_page/explorer_page.dart';
import 'pages/posts_page/posts_controller.dart';
import 'pages/posts_page/posts_page.dart';
import 'pages/search_page/search_page.dart';
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
  late void Function(List<PostModel>) funcNewPosts;
  @override
  void initState() {
    pages = [
      PostsPage(user: widget.user),
      ExplorerPage(),
      SearchPage(),
    ];
    super.initState();
  }

  void controlRoutes() async {
    Map<String, dynamic> arguments = {"user": widget.user};
    int index = indexPage;
    indexPage = 0;
    setState(() {});
    if (index == 3) {
      var posts = await Navigator.pushNamed(context, RouterClass.profile,
          arguments: arguments);
      if ((posts is List) && posts[0] is List<PostModel>) {
        PostsController postsController = PostsController();
        postsController.insertPosts(posts[0]);
        print(posts);
      }
      if ((posts is List) && posts[1] is List<String>) {
        PostsController postsController = PostsController();
        postsController.removePosts(posts[1]);
        print(posts);
      }
    } else if (index == 4) {
      print('CreatePostPage');
      Navigator.pushNamed(context, RouterClass.createPost,
          arguments: arguments);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppThemeController().colorStatus,
      sized: false,
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        appBar: AppBarHome(
          statusBarHeight: statusBarHeight,
          createPost: () {
            indexPage = 4;
            controlRoutes();
          },
        ),
        bottomNavigationBar: BottomNavigationBarHome(
          onTap: (index) {
            indexPage = index;
            controlRoutes();
          },
        ),
        body: pages[indexPage],
        // floatingActionButton: FloatingActionButton(onPressed: () async {
        //   try {
        //     await AppThemeController().toggleThemeMode();
        //   } catch (e) {}
        // }),
      ),
    );
  }
}
