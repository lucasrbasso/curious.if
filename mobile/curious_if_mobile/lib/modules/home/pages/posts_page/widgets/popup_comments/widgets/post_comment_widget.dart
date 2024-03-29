import 'package:flutter/material.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../domain/post/model/post_model.dart';

class PostCommentWidget extends StatelessWidget {
  final PostModel post;
  const PostCommentWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppTheme.colors.backgroundTextForm,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Spotted#${post.numberPost.toString().padLeft(4, '0')}",
              style: AppTheme.textStyles.titlePost,
            ),
            const SizedBox(height: 2),
            if (post.forPeople.isNotEmpty) ...[
              Text.rich(TextSpan(
                  text: "Para: ",
                  style: AppTheme.textStyles.titleTextPost,
                  children: [
                    TextSpan(
                        text: post.forPeople,
                        style: AppTheme.textStyles.subtitleTextPost)
                  ])),
            ],
            const SizedBox(height: 2),
            Text(post.content, style: AppTheme.textStyles.subtitleTextPost),
          ],
        ),
      ),
    );
  }
}
