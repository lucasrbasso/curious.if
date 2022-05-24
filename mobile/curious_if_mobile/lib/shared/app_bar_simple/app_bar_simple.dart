import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/core.dart';
import '../../domain/login/model/user_model.dart';
import '../../modules/account_page/widgets/widget_form/widget_form.dart';

class AppBarSimple extends StatelessWidget with PreferredSizeWidget {
  final String label;
  final UserModel user;
  final bool hasButton;
  const AppBarSimple({
    Key? key,
    required this.label,
    required this.user,
    this.hasButton = false,
  }) : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: AppThemeController().colorStatus,
      title: Text(label, style: AppTheme.textStyles.textHeadingFour),
      centerTitle: true,
      actions: [
        if (hasButton) ...[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.bars,
              ),
              padding: EdgeInsets.zero,
              tooltip: "Opções",
              splashRadius: 24,
              iconSize: 20,
              color: AppTheme.colors.backgroundButton,
              onPressed: () {
                Widget sheet = WidgetForm(key: UniqueKey(), user: user);
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: sheet,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ],
      leading: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          tooltip: "Voltar",
          padding: EdgeInsets.zero,
          splashRadius: 24,
          iconSize: 20,
          color: AppTheme.colors.backgroundButton,
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
