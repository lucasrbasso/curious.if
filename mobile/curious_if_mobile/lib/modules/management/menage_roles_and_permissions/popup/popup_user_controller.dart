import '../../../../domain/management/model/user_management_model.dart';
import '../../../../domain/management/usecase/management_usecase.dart';
import '../../../../domain/roles-permission/model/roles_permission_model.dart';

class PopupUserController {
  UserManagementModel user;
  final Function(UserManagementModel) onChanged;
  final ManagementUsecase managementUsecase = ManagementUsecase();
  PopupUserController({
    required this.user,
    required this.onChanged,
  });

  List<bool> listPermissions() {
    return Permission.values.map((e) => user.permissions.contains(e)).toList();
  }

  List<bool> listRoles() {
    return Roles.values.map((e) => user.roles.contains(e)).toList();
  }

  Future<bool> setPermission(int index, bool add) async {
    try {
      UserManagementModel newUser = user.copyWith();
      if (add) {
        newUser.permissions.add(Permission.values[index]);
      } else {
        newUser.permissions.remove(Permission.values[index]);
      }
      await onChanged(newUser);
      user = newUser.copyWith();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setRoles(int index, bool add) async {
    try {
      UserManagementModel newUser = user.copyWith();
      if (add) {
        newUser.roles.add(Roles.values[index]);
      } else {
        newUser.roles.remove(Roles.values[index]);
      }

      await onChanged(newUser);

      user = newUser.copyWith();

      return true;
    } catch (e) {
      return false;
    }
  }
}
