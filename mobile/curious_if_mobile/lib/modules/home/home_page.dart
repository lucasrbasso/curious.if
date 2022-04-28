import 'package:flutter/material.dart';

import '../../domain/login/model/user_model.dart';
import '../../domain/post/datasource/post_api.dart';
import '../../domain/post/model/post_model.dart';
import '../../domain/post/repository/post_repository.dart';

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        try {
          List<PostModel> response = await PostRepository().listPosts(
              token: widget.user.token, cursorID: '', takeValue: '10');
          print(response);
        } catch (e) {
          print(e);
        }
      }),
    );
  }
}
