import '../../../domain/management/model/user_management_model.dart';

abstract class ManageUserState {}

class ManageUserStateEmpty extends ManageUserState {}

class ManageUserStateLoading extends ManageUserState {}

class ManageUserStateFailure extends ManageUserState {
  final String message;
  ManageUserStateFailure({
    required this.message,
  });
}

class ManageUserStateSuccess extends ManageUserState {
  final String message;
  final List<UserManagementModel> users;
  ManageUserStateSuccess({
    required this.message,
    required this.users,
  });
}
