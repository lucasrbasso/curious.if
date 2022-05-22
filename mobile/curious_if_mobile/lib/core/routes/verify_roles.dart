import 'package:curious_if_mobile/domain/login/model/user_model.dart';

import '../../domain/roles-permission/model/roles_permission_model.dart';

class VerifyRoles {
  static bool hasUser(UserModel? user) => user != null;
  static bool verifyMod(UserModel user) => user.roles.contains(Roles.mod);
  static bool verifyAdmin(UserModel user) => user.roles.contains(Roles.admin);
}
