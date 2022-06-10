import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../shimmer_container/shimmer_container_widget.dart';

class ShimmerRowWidget extends StatelessWidget {
  const ShimmerRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
