import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/core.dart';

class MenageRolesAndPermissionsPage extends StatefulWidget {
  const MenageRolesAndPermissionsPage({Key? key}) : super(key: key);

  @override
  State<MenageRolesAndPermissionsPage> createState() =>
      _MenageRolesAndPermissionsPageState();
}

class _MenageRolesAndPermissionsPageState
    extends State<MenageRolesAndPermissionsPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppThemeController().colorStatus,
        sized: false,
        child: Container());
  }
}
