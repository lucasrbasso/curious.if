import 'package:curious_if_mobile/shared/shimmer_container/shimmer_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../core/core.dart';
import '../../../../../domain/management/model/user_management_model.dart';
import '../../../../../shared/shimmer_row/shimmer_row_widget.dart';

class UserWidget extends StatelessWidget {
  final UserManagementModel user;
  final bool loading;
  final VoidCallback? onTap;
  const UserWidget({
    Key? key,
    required this.user,
    this.loading = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: AppTheme.colors.backgroundTextForm,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (loading) ...[
                const ShimmerRowWidget(),
              ] else ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle_rounded,
                        color: AppTheme.colors.backgroundButton,
                        size: 10.w,
                      ),
                      SizedBox(width: 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: AppTheme.textStyles.titlePost,
                          ),
                          Text(
                            user.email,
                            style: AppTheme.textStyles.titlePost,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
