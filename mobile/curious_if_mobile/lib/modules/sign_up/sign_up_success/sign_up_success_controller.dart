import 'package:flutter/material.dart';

import '../../../core/core.dart';

class SignUpSuccessController {
  void navigationLogin(BuildContext context, String email) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      RouterClass.login,
      (Route<dynamic> route) => route.settings.name == RouterClass.home,
      arguments: {"email": email},
    );
  }
}
