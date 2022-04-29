import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../domain/login/model/user_model.dart';
import 'create_post_controller.dart';
import 'form_create_post/form_create_post.dart';

class CreatePostPage extends StatefulWidget {
  final UserModel user;
  final VoidCallback onSuccess;
  const CreatePostPage({
    Key? key,
    required this.user,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late CreatePostController _createPostController;
  @override
  void initState() {
    _createPostController = CreatePostController();
    _createPostController.autoRun(context, widget.onSuccess);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 70, left: 38, right: 38),
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        Center(
            child: Text("Envie sua Cantada",
                style: AppTheme.textStyles.textHeadingThree)),
        const SizedBox(height: 50),
        Text("Para:", style: AppTheme.textStyles.subtitleTextPost),
        const SizedBox(height: 2),
        FormCreatePostWidget(
          onSaved: (Map<String, dynamic> map) async {
            return await _createPostController.createPost(
                user: widget.user, content: map["message"]);
          },
        )
      ],
    );
  }
}
