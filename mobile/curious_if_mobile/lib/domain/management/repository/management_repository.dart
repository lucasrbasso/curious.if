import '../../roles-permission/model/roles_permission_model.dart';
import '../datasource/management_api.dart';
import '../model/user_management_model.dart';

abstract class IManagementRepository {
  Future<List<UserManagementModel>> getUsers(String token);
  Future<String> putUsers(
      String id, String token, List<Permission> permissions, List<Roles> roles);

  void dispose();
}

class ManagementRepository implements IManagementRepository {
  final IManagementApi _datasource;

  ManagementRepository({IManagementApi? datasource})
      : _datasource = datasource ?? ManagementApi();

  @override
  Future<List<UserManagementModel>> getUsers(String token) async {
    try {
      String response = await _datasource.getUsers(token);
      List<UserManagementModel> listUserManagement =
          UserManagementModel.fromApi(response);
      return listUserManagement;
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  @override
  Future<String> putUsers(String id, String token, List<Permission> permissions,
      List<Roles> roles) async {
    try {
      String response =
          await _datasource.putUsers(id, token, permissions, roles);
      return response;
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  Object handleErrorReturn(Object e) {
    if (e is String) {
      return e;
    } else if (e is Map<String, dynamic>) {
      if (e["message"] is String) {
        throw e["message"];
      } else if (e["message"] is List) {
        List errors = e["message"];
        String error = "";
        for (var element in errors) {
          Map<String, dynamic> errorMap = element["constraints"];
          errorMap.forEach((key, value) {
            error += value + "\n";
          });
        }
        throw error;
      } else {
        throw "Internal error";
      }
    }
    return e;
  }

  @override
  void dispose() {
    _datasource.dispose();
  }
}
