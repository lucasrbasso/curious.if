import '../../../../domain/post/model/post_model.dart';

abstract class CreatePostState {}

class CreatePostStateEmpty extends CreatePostState {}

class CreatePostStateLoading extends CreatePostState {}

class CreatePostStateFailure extends CreatePostState {
  final String message;
  CreatePostStateFailure({
    required this.message,
  });
}

class CreatePostStateSuccess extends CreatePostState {
  final String message;
  final PostModel post;
  CreatePostStateSuccess({
    required this.message,
    required this.post,
  });
}
