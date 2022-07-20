import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../../domain/post/model/post_model.dart';
import '../../../../../../shared/shimmer_row/shimmer_row_widget.dart';
import '../popup_comments/widgets/popup_menu_buttons.dart';
import 'comments_button_widget.dart';
import 'like_button_widget.dart';

class PostWidget extends StatelessWidget {
  final PostModel post;
  final bool loading;
  final Future<bool?> Function(bool) onTapLike;
  final Function() onTapComment;
  final Future<void> Function() onDenounce;
  const PostWidget({
    Key? key,
    required this.post,
    this.loading = false,
    required this.onTapLike,
    required this.onTapComment,
    required this.onDenounce,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(post.toString());
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.colors.backgroundTextForm,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (loading) ...[
                  const ShimmerRowWidget(),
                ] else ...[
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
                  Text(post.content,
                      style: AppTheme.textStyles.subtitleTextPost),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      LikeButtonWidget(
                        isLiked: post.isLiked,
                        numberOfLikes: post.numberOfLikes,
                        onTap: onTapLike,
                      ),
                      const SizedBox(width: 8),
                      CommentButtonWidget(
                        onTap: onTapComment,
                        numberOfComments: post.numberOfComments,
                      )
                    ],
                  )
                ]
              ],
            ),
            if (!loading) ...[
              PopupMenuButtons(
                isOwner: false,
                onDelete: () async => false,
                onDenounce: onDenounce,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
