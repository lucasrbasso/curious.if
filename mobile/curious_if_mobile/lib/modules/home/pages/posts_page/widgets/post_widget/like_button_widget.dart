import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/core.dart';

class LikeButtonWidget extends StatelessWidget {
  final bool isLiked;
  final int numberOfLikes;
  final Future<bool?> Function(bool) onTap;
  const LikeButtonWidget({
    Key? key,
    required this.isLiked,
    required this.numberOfLikes,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: LikeButton(
          padding: EdgeInsets.symmetric(horizontal: 2),
          onTap: onTap,
          isLiked: isLiked,
          size: 20,
          bubblesSize: 60,
          circleColor: CircleColor(
              start: Colors.pink.shade100, end: Colors.pink.shade600),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Colors.pink.shade100,
            dotSecondaryColor: Colors.pink.shade600,
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? Colors.pink.shade600 : Colors.grey.shade600,
              size: 20,
            );
          },
          likeCount: numberOfLikes,
          countBuilder: (count, bool isLiked, String text) {
            var color = isLiked ? Colors.pink.shade600 : Colors.grey.shade600;
            return Text(
              text,
              style: TextStyle(color: color),
            );
          },
        ),
      ),
    );
  }
}
