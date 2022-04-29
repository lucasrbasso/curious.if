import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import 'form_create_post/form_create_post.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
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
            map.forEach((key, value) {
              print(value);
            });
          },
        )
      ],
    );
  }
}
