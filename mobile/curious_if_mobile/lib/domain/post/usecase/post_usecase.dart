import '../model/post_model.dart';
import '../repository/post_repository.dart';

abstract class IPostUseCase {
  Future<List<PostModel>> listPosts({
    String cursorID,
    String takeValue,
  });
  Future<PostModel> createPost({
    required String token,
    required String to,
    required String content,
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
  }) async {
    try {
      List<PostModel> posts = await _repository.listPosts(
        cursorID: cursorID,
        takeValue: takeValue,
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
  void dispose() {
    _repository.dispose();
  }
}
