import 'package:flutter/material.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../shared/shimmer_row/shimmer_row_widget.dart';

class ShimmerCommentWidget extends StatelessWidget {
  const ShimmerCommentWidget({Key? key}) : super(key: key);

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
        child: ShimmerRowWidget(scale: 0.9),
      ),
    );
  }
}
