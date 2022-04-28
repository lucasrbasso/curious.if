import '../model/post_model.dart';
import '../repository/post_repository.dart';

abstract class IPostUseCase {
  Future<List<PostModel>> listPosts({
    required String token,
    String cursorID,
    String takeValue,
  });
  void dispose();
}

class PostUseCase implements IPostUseCase {
  final IPostRepository _repository;

  PostUseCase({IPostRepository? repository})
      : _repository = repository ?? PostRepository();

  @override
  Future<List<PostModel>> listPosts({
    required String token,
    String cursorID = '',
    String takeValue = '10',
  }) async {
    try {
      List<PostModel> user = await _repository.listPosts(
        cursorID: cursorID,
        takeValue: takeValue,
        token: token,
      );
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
