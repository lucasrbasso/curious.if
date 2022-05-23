import 'package:curious_if_mobile/domain/login/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../domain/roles-permission/model/roles_permission_model.dart';
import '../../modules/account_not_logged/account_not_logged_page.dart';
import '../../modules/not_has_authorization/not_has_authorization_page.dart';
import '../core.dart';

class VerifyRoles {
  bool hasUser(UserModel? user) => user != null;
  bool verifyMod(UserModel? user) => user?.roles.contains(Roles.mod) ?? false;
  bool verifyAdmin(UserModel? user) =>
      user?.roles.contains(Roles.admin) ?? false;
  bool verifyCanPost(UserModel? user) =>
      user?.permissions.contains(Permission.canPost) ?? false;

  verifyRoleAndUser(UserModel? user, bool authorization, Widget page) {
    if (hasUser(user)) {
      if (authorization) {
        return page;
      } else {
        return NotHasAuthorizationPage(key: UniqueKey());
      }
    } else {
      return AccountNotLoggedPage(key: UniqueKey());
    }
  }
}
