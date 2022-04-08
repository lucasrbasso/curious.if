import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/core.dart';

class CardPerfilWidget extends StatelessWidget {
  final VoidCallback callback;
  const CardPerfilWidget({
    Key? key,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.h),
      child: ListTile(
        onTap: callback,
        contentPadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 15.w,
              height: 15.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.w),
                color: Colors.green.shade400,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.w),
                child: Image.network(
                  'user.photoUrl',
                ),
              ),
              // child: Icon(Icons.person, size: 10.w, color: Colors.white),
            ),
            SizedBox(
              width: 3.5.w,
            ),
            SizedBox(
              width: 48.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'user.name',
                    style: AppTheme.textStyles.bodyCardTitleSettings,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'user.email',
                    style: AppTheme.textStyles.bodyCardSubtitleSettings,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.navigate_next_sharp,
          size: 12.5.w,
          color: AppTheme.colors.appBarIconSettings,
        ),
      ),
    );
  }
}
