import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonWidget extends StatelessWidget {
  final bool isLiked;
  final int numberOfLikes;
  final CountPostion countPostion;
  final Future<bool?> Function(bool) onTap;
  const LikeButtonWidget({
    Key? key,
    required this.isLiked,
    required this.numberOfLikes,
    required this.onTap,
    this.countPostion = CountPostion.right,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: LikeButton(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          countPostion: countPostion,
          likeCountAnimationType: numberOfLikes < 1000
              ? LikeCountAnimationType.part
              : LikeCountAnimationType.none,
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
            Color color = isLiked ? Colors.pink.shade600 : Colors.grey.shade600;

            String texto = count! >= 1000
                ? (count / 1000.0).toStringAsFixed(1) + 'k'
                : text;
            print("Antes");
            Widget result = Text(
              texto,
              style: TextStyle(color: color),
            );
            return result;
          },
        ),
      ),
    );
  }
}
