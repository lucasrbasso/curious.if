import 'dart:convert';

import 'package:collection/collection.dart';

import '../../roles-permission/model/roles_permission_model.dart';

class UserModel {
  final String name;
  final String email;
  final List<Permission> permissions;
  final List<Roles> roles;
  final String token;
  UserModel({
    required this.name,
    required this.email,
    required this.permissions,
    required this.roles,
    required this.token,
  });

  UserModel copyWith({
    String? name,
    String? email,
    List<Permission>? permissions,
    List<Roles>? roles,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      permissions: permissions ?? this.permissions,
      roles: roles ?? this.roles,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({
      'permissions': permissions.map((x) => x.parseStringPermission).toList()
    });
    result.addAll({'roles': roles.map((x) => x.parseStringRoles).toList()});
    result.addAll({'token': token});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      permissions: List<Permission>.from(map['permissions']
              ?.map((permission) => permission.toString().parsePermission) ??
          []),
      roles: List<Roles>.from(
          map['roles']?.map((role) => role.toString().parseRoles) ?? []),
      token: map['access_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, permissions: $permissions, roles: $roles, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        listEquals(other.permissions, permissions) &&
        listEquals(other.roles, roles) &&
        other.token == token;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        permissions.hashCode ^
        roles.hashCode ^
        token.hashCode;
  }
}
