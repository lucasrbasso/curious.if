import 'package:flutter/material.dart';

import '../../../../domain/login/model/user_model.dart';

class AccountPage extends StatelessWidget {
  final UserModel? user;
  const AccountPage({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
