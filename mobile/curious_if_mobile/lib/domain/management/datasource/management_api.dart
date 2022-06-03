import 'dart:convert';
import 'package:http/http.dart' show Client;

import '../../../core/core.dart';
import '../../login/model/user_model.dart';
import '../../roles-permission/model/roles_permission_model.dart';

abstract class IManagementApi {
  Future<String> getUsers(String token);
  Future<String> putUsers(
      String id, String token, List<Permission> permissions, List<Roles> roles);
  void dispose();
}

class ManagementApi implements IManagementApi {
  final Client client = Client();
  final String server = UtilsConst.server;

  @override
  void dispose() {
    client.close();
  }

  @override
  Future<String> getUsers(String token) async {
    try {
      final response = await client.get(
        Uri.parse("${server}api/users/"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw json.decode(response.body);
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> putUsers(String id, String token, List<Permission> permissions,
      List<Roles> roles) async {
    try {
      final response = await client
          .put(
            Uri.parse("${server}api/users/allowing/$id"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: json.encode(<String, dynamic>{
              'permissions':
                  permissions.map((e) => e.parseStringPermission).toList(),
              'roles': roles.map((e) => e.parseStringRoles).toList()
            }),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw json.decode(response.body);
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      rethrow;
    }
  }
}
