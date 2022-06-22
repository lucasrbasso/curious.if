import '../../roles-permission/model/roles_permission_model.dart';
import '../model/post_management_model.dart';
import '../model/user_management_model.dart';
import '../repository/management_repository.dart';

abstract class IManagementUsecase {
  Future<List<UserManagementModel>> getUsers(String token);

  Future<String> putUsers(
      String id, String token, List<Permission> permissions, List<Roles> roles);

  Future<List<PostManagementModel>> getListPostsUnauthorized(String token);
  Future<String> patchPost(String id, String token, bool published);
  void dispose();
}

class ManagementUsecase implements IManagementUsecase {
  final IManagementRepository _repository;

  ManagementUsecase({IManagementRepository? repository})
      : _repository = repository ?? ManagementRepository();

  @override
  Future<List<UserManagementModel>> getUsers(String token) async {
    try {
      List<UserManagementModel> listUsers = await _repository.getUsers(token);
      listUsers.sort((a, b) => a.name.compareTo(b.name));
      return listUsers;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> putUsers(String id, String token, List<Permission> permissions,
      List<Roles> roles) async {
    try {
      String response =
          await _repository.putUsers(id, token, permissions, roles);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PostManagementModel>> getListPostsUnauthorized(
      String token) async {
    try {
      List<PostManagementModel> listPostsUnauthorized =
          await _repository.getListPostsUnauthorized(token);
      listPostsUnauthorized.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      return listPostsUnauthorized;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> patchPost(String id, String token, bool published) async {
    try {
      String response = await _repository.patchPost(id, token, published);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
