import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../shimmer_container/shimmer_container_widget.dart';

class ShimmerRowWidget extends StatelessWidget {
  final double scale;
  const ShimmerRowWidget({Key? key, this.scale = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 1.w * scale),
        ShimmerContainerWidget(height: 22.w * scale, width: 25.w * scale),
        SizedBox(width: 4.w * scale),
        Column(
          children: [
            ShimmerContainerWidget(height: 4.w * scale, width: 57.w * scale),
            SizedBox(height: 4.w * scale),
            ShimmerContainerWidget(height: 1.5.w * scale, width: 57.w * scale),
            SizedBox(height: 1.5.w * scale),
            ShimmerContainerWidget(height: 1.5.w * scale, width: 57.w * scale),
            SizedBox(height: 1.5.w),
            ShimmerContainerWidget(height: 1.5.w * scale, width: 57.w * scale),
            SizedBox(height: 1.5.w * scale),
            ShimmerContainerWidget(height: 1.5.w * scale, width: 57.w * scale),
          ],
        )
      ],
    );
  }
}
