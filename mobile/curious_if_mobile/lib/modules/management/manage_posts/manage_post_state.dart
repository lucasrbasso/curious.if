import '../../../domain/management/model/post_management_model.dart';

abstract class ManagePostState {}

class ManagePostStateEmpty extends ManagePostState {}

class ManagePostStateLoading extends ManagePostState {}

class ManagePostStateFailure extends ManagePostState {
  final String message;
  ManagePostStateFailure({
    required this.message,
  });
}

class ManagePostStateSuccess extends ManagePostState {
  final String message;
  final List<PostManagementModel> posts;
  ManagePostStateSuccess({
    required this.message,
    required this.posts,
  });
}
