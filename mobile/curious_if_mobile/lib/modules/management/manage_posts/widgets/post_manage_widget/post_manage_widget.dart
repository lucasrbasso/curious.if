import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../domain/management/model/post_management_model.dart';
import '../../../../../shared/shimmer_row/shimmer_row_widget.dart';

class PostManageWidget extends StatelessWidget {
  final PostManagementModel post;
  final bool loading;
  const PostManageWidget({
    Key? key,
    required this.post,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppTheme.colors.backgroundTextForm,
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: const BoxConstraints(minHeight: 78),
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
            ]
          ],
        ),
      ),
    );
  }
}
