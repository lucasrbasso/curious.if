import 'package:curious_if_mobile/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainerWidget extends StatelessWidget {
  final double height;
  final double width;
  const ShimmerContainerWidget({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: AppTheme.colors.colorShimmer,
        highlightColor: AppTheme.colors.colorSecondaryShimmer,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.colors.colorShimmer,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
