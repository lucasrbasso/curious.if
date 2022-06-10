import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/core.dart';
import '../../../../../domain/management/model/post_management_model.dart';
import '../post_manage_widget/post_manage_widget.dart';
import 'slidable_custom_action_widget.dart';

class SlidableCardWidget extends StatelessWidget {
  final void Function(BuildContext, bool) onPublishEdit;
  final Future<bool> Function(bool) confirmDismiss;
  final void Function(bool) onDismissed;
  final PostManagementModel post;
  const SlidableCardWidget(
      {Key? key,
      required this.onPublishEdit,
      required this.confirmDismiss,
      required this.onDismissed,
      required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      groupTag: 0,
      key: UniqueKey(),
      startActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const DrawerMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => onDismissed(true),
          confirmDismiss: () => confirmDismiss(true),
        ),
        children: [
          SlidableCustomActionWidget(
            onPressed: (context) => onPublishEdit(context, true),
            autoClose: true,
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.check_circle,
            label: "Publicar",
            sizeIcon: 4.h,
            style: AppTheme.textStyles.textSlidableButton,
          ),
        ],
      ),
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const DrawerMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => onDismissed(false),
          confirmDismiss: () => confirmDismiss(false),
        ),
        children: [
          SlidableCustomActionWidget(
            onPressed: (context) => onPublishEdit(context, false),
            autoClose: true,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Deletar",
            sizeIcon: 4.h,
            style: AppTheme.textStyles.textSlidableButton,
          ),
        ],
      ),
      child: PostManageWidget(key: UniqueKey(), post: post),
    );
  }
}
