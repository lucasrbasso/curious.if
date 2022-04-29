import '../../../../domain/post/model/post_model.dart';

abstract class PostsState {}

class PostsStateEmpty extends PostsState {}

class PostsStateLoading extends PostsState {}

class PostsStateFailure extends PostsState {
  final String message;
  PostsStateFailure({
    required this.message,
  });
}

class PostsStateSuccess extends PostsState {
  final String message;
  final List<PostModel> posts;
  PostsStateSuccess({
    required this.message,
    required this.posts,
  });
}
