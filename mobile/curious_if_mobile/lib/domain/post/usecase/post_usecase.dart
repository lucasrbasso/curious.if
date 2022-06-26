import '../model/post_model.dart';
import '../repository/post_repository.dart';

abstract class IPostUseCase {
  Future<List<PostModel>> listPosts({
    String cursorID,
    String takeValue,
    String? id,
  });
  Future<PostModel> createPost({
    required String token,
    required String to,
    required String content,
  });
  Future<void> setLikePost({
    required String token,
    required String id,
    required bool isLiked,
  });
  void dispose();
}

class PostUseCase implements IPostUseCase {
  final IPostRepository _repository;

  PostUseCase({IPostRepository? repository})
      : _repository = repository ?? PostRepository();

  @override
  Future<List<PostModel>> listPosts({
    String cursorID = '',
    String takeValue = '10',
    String? id,
  }) async {
    try {
      List<PostModel> posts = await _repository.listPosts(
        cursorID: cursorID,
        takeValue: takeValue,
        id: id,
      );
      return posts;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PostModel> createPost({
    required String token,
    required String to,
    required String content,
  }) async {
    try {
      PostModel post = await _repository.createPost(
        to: to,
        content: content,
        token: token,
      );
      return post;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setLikePost({
    required String token,
    required String id,
    required bool isLiked,
  }) async {
    try {
      if (isLiked) {
        _repository.likePost(token: token, id: id);
      } else {
        _repository.removeLikePost(token: token, id: id);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
