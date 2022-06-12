import 'package:curious_if_mobile/shared/shimmer_container/shimmer_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/core.dart';
import '../../../../../../domain/post/model/post_model.dart';
import '../../../../../../shared/shimmer_row/shimmer_row_widget.dart';
import 'like_button_widget.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;
  final bool loading;
  final Future<bool?> Function(bool) onTap;
  const PostWidget({
    Key? key,
    required this.post,
    this.loading = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(post);
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors.backgroundTextForm,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (loading) ...[
              const ShimmerRowWidget(),
            ] else ...[
              Text(
                "Spotted#0001",
                style: AppTheme.textStyles.titlePost,
              ),
              SizedBox(height: 2),
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
              SizedBox(height: 2),
              Text(post.content, style: AppTheme.textStyles.subtitleTextPost),
              SizedBox(height: 4),
              Row(
                children: [
                  LikeButtonWidget(
                    isLiked: post.isLiked,
                    numberOfLikes: post.numberOfLikes,
                    onTap: onTap,
                  ),
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
