import 'dart:convert';

import 'package:collection/collection.dart' show DeepCollectionEquality;
import '../../roles-permission/model/roles_permission_model.dart';

class UserManagementModel {
  final String id;
  final String name;
  final String email;
  final bool isValidated;
  final List<Permission> permissions;
  final List<Roles> roles;
  final DateTime createdAt;
  final DateTime updatedAt;
  UserManagementModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isValidated,
    required this.permissions,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
  });

  UserManagementModel copyWith({
    String? id,
    String? name,
    String? email,
    bool? isValidated,
    List<Permission>? permissions,
    List<Roles>? roles,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserManagementModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      isValidated: isValidated ?? this.isValidated,
      permissions: permissions ?? this.permissions,
      roles: roles ?? this.roles,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'isValidated': isValidated,
      'permissions': permissions.map((x) => x.parseStringPermission).toList(),
      'roles': roles.map((x) => x.parseStringRoles).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory UserManagementModel.fromMap(Map<String, dynamic> map) {
    return UserManagementModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      isValidated: map['isValidated'] ?? false,
      permissions: List<Permission>.from(
          map['permissions']?.map((x) => x.toString().parsePermission)),
      roles:
          List<Roles>.from(map['roles']?.map((x) => x.toString().parseRoles)),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  factory UserManagementModel.mock() {
    return UserManagementModel(
      id: '',
      name: '',
      email: '',
      isValidated: false,
      permissions: [],
      roles: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  static List<UserManagementModel> fromApi(String source) {
    List<dynamic> list = json.decode(source);
    List<UserManagementModel> userManagementModel = [];
    list.forEach((value) {
      userManagementModel.add(UserManagementModel.fromMap(value));
    });
    return userManagementModel;
  }

  factory UserManagementModel.fromJson(String source) =>
      UserManagementModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserManagementModel(id: $id, name: $name, email: $email, isValidated: $isValidated, permissions: $permissions, roles: $roles, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is UserManagementModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.isValidated == isValidated &&
        listEquals(other.permissions, permissions) &&
        listEquals(other.roles, roles) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        isValidated.hashCode ^
        permissions.hashCode ^
        roles.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
