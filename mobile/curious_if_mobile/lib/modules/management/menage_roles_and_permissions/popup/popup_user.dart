import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/core.dart';
import '../../../../domain/management/model/user_management_model.dart';
import '../../../../domain/roles-permission/model/roles_permission_model.dart';
import 'popup_user_controller.dart';

class PopupUser extends StatefulWidget {
  final UserManagementModel user;
  final Function(UserManagementModel) onChanged;
  const PopupUser({
    Key? key,
    required this.user,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<PopupUser> createState() => _PopupUserState();
}

class _PopupUserState extends State<PopupUser> {
  late PopupUserController popupUserController;
  late List<bool> listPermissions;
  late List<bool> listRoles;
  @override
  void initState() {
    popupUserController =
        PopupUserController(user: widget.user, onChanged: widget.onChanged);
    listPermissions = popupUserController.listPermissions();
    listRoles = popupUserController.listRoles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(bottom: 24),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.0))),
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
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
                    widget.user.name,
                    style: AppTheme.textStyles.titlePost,
                  ),
                  Text(
                    widget.user.email,
                    style: AppTheme.textStyles.titlePost,
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.cancel_outlined, color: Colors.red),
          ),
        ],
      ),

      // ...Permission.values.map((e) => Text(e.toString())).toList(),
      // ...Roles.values.map((e) => Text(e.toString())).toList(),
      content: Container(
        width: 80.w,
        padding: EdgeInsets.only(bottom: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              Container(
                color: AppTheme.colors.background,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.shieldHalved,
                      color: AppTheme.colors.backgroundButton,
                    ),
                    SizedBox(width: 12),
                    Text("Roles", style: AppTheme.textStyles.titlePost),
                  ],
                ),
              ),
              ...Roles.values.map((e) {
                return CheckboxListTile(
                  title: Text(e.label,
                      style: AppTheme.textStyles.subtitleTextPost),
                  value: listRoles[e.index],
                  activeColor: AppTheme.colors.backgroundButton,
                  side: BorderSide(color: AppTheme.colors.textSimple, width: 2),
                  onChanged: (value) {
                    if (value != null) {
                      popupUserController
                          .setRoles(e.index, value)
                          .then((success) {
                        if (success) {
                          listRoles[e.index] = value;
                          setState(() {});
                        }
                      });
                    }
                  },
                );
              }).toList(),
              SizedBox(height: 12),
              Container(
                color: AppTheme.colors.background,
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.shieldHalved,
                      color: AppTheme.colors.backgroundButton,
                    ),
                    SizedBox(width: 12),
                    Text("Permissões", style: AppTheme.textStyles.titlePost),
                  ],
                ),
              ),
              ...Permission.values.map((e) {
                return CheckboxListTile(
                  title: Text(e.label,
                      style: AppTheme.textStyles.subtitleTextPost),
                  value: listPermissions[e.index],
                  activeColor: AppTheme.colors.backgroundButton,
                  side: BorderSide(color: AppTheme.colors.textSimple, width: 2),
                  onChanged: (value) {
                    if (value != null) {
                      popupUserController
                          .setPermission(e.index, value)
                          .then((success) {
                        if (success) {
                          listPermissions[e.index] = value;
                          setState(() {});
                        }
                      });
                    }
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
      backgroundColor: AppTheme.colors.backgroundTextForm,
    );
  }
}
