enum Permission { canRead, canPost }
enum Roles { admin, mod }

extension StringToPermission on String {
  Permission get parsePermission => {
        "USER.CAN_READ": Permission.canRead,
        "USER.CAN_POST": Permission.canPost,
      }[this]!;
}

extension PermissionToString on Permission {
  String get parseStringPermission => {
        Permission.canRead: "USER.CAN_READ",
        Permission.canPost: "USER.CAN_POST"
      }[this]!;
}

extension StringToRoles on String {
  Roles get parseRoles => {
        "USER.ADMIN": Roles.admin,
        "USER.MOD": Roles.mod,
      }[this]!;
}

extension RolesToString on Roles {
  String get parseStringRoles =>
      {Roles.admin: "USER.ADMIN", Roles.mod: "USER.MOD"}[this]!;
}
