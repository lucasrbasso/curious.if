import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../../../../core/core.dart';

class PopupMenuButtons extends StatelessWidget {
  final bool isOwner;

  final Future<bool> Function() onDelete;
  const PopupMenuButtons({
    Key? key,
    required this.isOwner,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6, right: 4),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          width: 24,
          height: 24,
          child: PopupMenuButton(
            iconSize: 24,
            splashRadius: 12,
            offset: Offset(-10, 0),
            icon: Icon(
              Icons.more_vert,
              color: AppTheme.colors.backgroundButton,
            ),
            padding: EdgeInsets.zero,
            color: AppTheme.colors.background,
            elevation: 20,
            itemBuilder: (context) => [
              PopupMenuItem(
                padding: EdgeInsets.zero,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SizedBox(width: 24),
                      Icon(
                        Icons.warning,
                        color: AppTheme.colors.titlePost,
                      ),
                      SizedBox(width: 6),
                      Text(
                        "Denunciar",
                        style: AppTheme.textStyles.subtitleTextPost,
                      ),
                      SizedBox(width: 24),
                    ],
                  ),
                ),
              ),
              if (isOwner)
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  onTap: () async {
                    await onDelete();
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SizedBox(width: 24),
                        Icon(Icons.delete, color: AppTheme.colors.titlePost),
                        SizedBox(width: 6),
                        Text(
                          "Excluir",
                          style: AppTheme.textStyles.subtitleTextPost,
                        ),
                        SizedBox(width: 24),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
