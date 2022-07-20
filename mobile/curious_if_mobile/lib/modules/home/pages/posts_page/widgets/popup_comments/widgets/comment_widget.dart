import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../domain/comment/model/comment_model.dart';
import '../../post_widget/like_button_widget.dart';
import 'popup_menu_buttons.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel commentModel;

  final Future<bool?> Function(bool) onTapLike;
  final Future<bool> Function() onDelete;
  final Future<void> Function() onDenounce;
  const CommentWidget({
    Key? key,
    required this.commentModel,
    required this.onTapLike,
    required this.onDelete,
    required this.onDenounce,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                height: 10.w,
                width: 10.w,
                padding: EdgeInsets.only(top: 6),
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Icon(
                      Icons.account_circle_rounded,
                      color: AppTheme.colors.backgroundButton,
                    )),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  LikeButtonWidget(
                    isLiked: commentModel.isLiked,
                    numberOfLikes: commentModel.numberOfLikes,
                    countPostion: commentModel.numberOfLikes > 999
                        ? CountPostion.bottom
                        : CountPostion.right,
                    onTap: onTapLike,
                  ),
                  SizedBox(width: 2),
                ],
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.colors.backgroundTextForm,
                borderRadius: BorderRadius.circular(12),
              ),
              padding:
                  const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commentModel.authorName,
                          style: AppTheme.textStyles.titlePost,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          commentModel.content,
                          style: AppTheme.textStyles.subtitleTextPost,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButtons(
                      onDenounce: onDenounce,
                      isOwner: commentModel.isOwner,
                      onDelete: onDelete),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
