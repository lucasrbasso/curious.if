import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/core.dart';
import '../../../../core/routes/verify_roles.dart';
import '../../../../domain/login/model/user_model.dart';
import 'button_icon_text.dart';

class WidgetForm extends StatefulWidget {
  final UserModel user;
  const WidgetForm({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<WidgetForm> createState() => _WidgetFormState();
}

class _WidgetFormState extends State<WidgetForm> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return IntrinsicHeight(
      child: Container(
        constraints: BoxConstraints(maxHeight: 80.h),
        decoration: BoxDecoration(
            color: AppTheme.colors.background,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 12),
            Container(
              width: 15.w,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.colors.textSimple.withOpacity(.25),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 18, bottom: 18),
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      ButtonIconText(
                        icon: Icons.settings,
                        label: "Configurações",
                        onTap: () {},
                      ),
                      ButtonIconText(
                        icon: Icons.watch_later_outlined,
                        label: "Atividade",
                        onTap: () {},
                      ),
                      if (VerifyRoles.verifyAdmin(widget.user) ||
                          VerifyRoles.verifyMod(widget.user)) ...[
                        ButtonIconText(
                          icon: FontAwesomeIcons.triangleExclamation,
                          label: "Denuncias",
                          onTap: () {},
                        ),
                        if (VerifyRoles.verifyAdmin(widget.user)) ...[
                          ButtonIconText(
                            icon: FontAwesomeIcons.addressBook,
                            label: "Gerenciar\nPermissões",
                            onTap: () {
                              Navigator.pushNamed(context,
                                  RouterClass.manageRolesAndPermissions,
                                  arguments: {'user': widget.user});
                            },
                          ),
                        ],
                        ButtonIconText(
                          icon: FontAwesomeIcons.signsPost,
                          label: "Gerenciar\nPostagens",
                          onTap: () {},
                        ),
                        ButtonIconText(
                          icon: FontAwesomeIcons.peopleGroup,
                          label: "Cadastros",
                          onTap: () {},
                        ),
                      ],
                      ButtonIconText(
                        icon: Icons.logout,
                        label: "Sair",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
