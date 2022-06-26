enum Permission {
  canRead("Pode Ler"),
  canPost("Pode Postar");

  final String label;
  const Permission(this.label);
}

enum Roles {
  admin("Administrador"),
  mod("Moderador");

  final String label;
  const Roles(this.label);
}

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
