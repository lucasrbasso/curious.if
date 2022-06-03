import 'package:curious_if_mobile/shared/shimmer_container/shimmer_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/core.dart';
import '../../../../../../domain/post/model/post_model.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;
  final bool loading;
  const PostWidget({
    Key? key,
    required this.post,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Row(
                children: [
                  SizedBox(width: 1.w),
                  ShimmerContainerWidget(height: 22.w, width: 25.w),
                  SizedBox(width: 4.w),
                  Column(
                    children: [
                      ShimmerContainerWidget(height: 4.w, width: 57.w),
                      SizedBox(height: 4.w),
                      ShimmerContainerWidget(height: 1.5.w, width: 57.w),
                      SizedBox(height: 1.5.w),
                      ShimmerContainerWidget(height: 1.5.w, width: 57.w),
                      SizedBox(height: 1.5.w),
                      ShimmerContainerWidget(height: 1.5.w, width: 57.w),
                      SizedBox(height: 1.5.w),
                      ShimmerContainerWidget(height: 1.5.w, width: 57.w),
                    ],
                  )
                ],
              ),
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
            ]
          ],
        ),
      ),
    );
  }
}
