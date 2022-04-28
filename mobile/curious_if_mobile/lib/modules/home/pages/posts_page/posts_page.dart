import 'package:flutter/material.dart';

import '../../../../domain/post/model/post_model.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final List<PostModel> posts = [];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Container(
          child: Text(posts[index].content),
        );
      },
    );
  }
}
