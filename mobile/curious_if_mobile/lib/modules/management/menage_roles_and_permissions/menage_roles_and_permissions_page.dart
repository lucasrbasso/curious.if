import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/core.dart';
import '../../../domain/login/model/user_model.dart';
import '../../../shared/app_bar_simple/app_bar_simple.dart';

class MenageRolesAndPermissionsPage extends StatefulWidget {
  final UserModel user;
  const MenageRolesAndPermissionsPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<MenageRolesAndPermissionsPage> createState() =>
      _MenageRolesAndPermissionsPageState();
}

class _MenageRolesAndPermissionsPageState
    extends State<MenageRolesAndPermissionsPage> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppThemeController().colorStatus,
      sized: false,
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        appBar: AppBarSimple(user: widget.user, label: "GERENCIAR PERMISSÕES"),
        body: Container(),
      ),
    );
  }
}
