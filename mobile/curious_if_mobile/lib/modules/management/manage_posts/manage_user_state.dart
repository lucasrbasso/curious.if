import '../../../domain/management/model/user_management_model.dart';

abstract class ManagePostsState {}

class ManagePostsStateEmpty extends ManagePostsState {}

class ManagePostsStateLoading extends ManagePostsState {}

class ManagePostsStateFailure extends ManagePostsState {
  final String message;
  ManagePostsStateFailure({
    required this.message,
  });
}

class ManagePostsStateSuccess extends ManagePostsState {
  final String message;
  final List<UserManagementModel> users;
  ManagePostsStateSuccess({
    required this.message,
    required this.users,
  });
}
