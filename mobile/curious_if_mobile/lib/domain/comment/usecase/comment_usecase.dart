import '../model/comment_model.dart';
import '../repository/comment_repository.dart';

abstract class ICommentUseCase {
  Future<CommentModel> createComment(String content, String postId);
  Future<List<CommentModel>> getAllCommentsPost(String postId);
  void dispose();
}

class CommentUseCase implements ICommentUseCase {
  final ICommentRepository _repository;

  CommentUseCase({ICommentRepository? repository})
      : _repository = repository ?? CommentRepository();

  @override
  Future<List<CommentModel>> getAllCommentsPost(String postId) async {
    try {
      List<CommentModel> comments =
          await _repository.getAllCommentsPost(postId);
      return comments;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CommentModel> createComment(String content, String postId) async {
    try {
      CommentModel comment = await _repository.createComment(content, postId);
      return comment;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
