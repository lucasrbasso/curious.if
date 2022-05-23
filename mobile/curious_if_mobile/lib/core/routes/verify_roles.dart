import 'package:curious_if_mobile/domain/login/model/user_model.dart';
import 'package:flutter/material.dart';

import '../../domain/roles-permission/model/roles_permission_model.dart';
import '../../modules/account_not_logged/account_not_logged_page.dart';
import '../../modules/not_has_authorization/not_has_authorization_page.dart';
import '../core.dart';

class VerifyRoles {
  static Widget accountNotLogged = AccountNotLoggedPage();
  static Widget notHasAuthorization = NotHasAuthorizationPage();

  static bool hasUser(UserModel? user) => user != null;
  static bool verifyMod(UserModel? user) =>
      user?.roles.contains(Roles.mod) ?? false;
  static bool verifyAdmin(UserModel? user) =>
      user?.roles.contains(Roles.admin) ?? false;
  static bool verifyCanPost(UserModel? user) =>
      user?.permissions.contains(Permission.canPost) ?? false;

  static verifyRoleAndUser(UserModel? user, bool authorization, Widget page) {
    if (hasUser(user)) {
      if (authorization) {
        return page;
      } else {
        return notHasAuthorization;
      }
    } else {
      return accountNotLogged;
    }
  }
}
