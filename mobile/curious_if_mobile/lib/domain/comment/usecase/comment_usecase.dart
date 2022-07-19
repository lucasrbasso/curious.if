import '../model/comment_model.dart';
import '../repository/comment_repository.dart';

abstract class ICommentUseCase {
  Future<CommentModel> createComment(
      String content, String postId, String token);
  Future<List<CommentModel>> getAllCommentsPost(String postId, String? userId);

  Future<void> setLikeComment({
    required String token,
    required String id,
    required bool isLiked,
  });

  Future<void> deleteComment({
    required String token,
    required String id,
  });
  void dispose();
}

class CommentUseCase implements ICommentUseCase {
  final ICommentRepository _repository;

  CommentUseCase({ICommentRepository? repository})
      : _repository = repository ?? CommentRepository();

  @override
  Future<List<CommentModel>> getAllCommentsPost(
      String postId, String? userId) async {
    try {
      List<CommentModel> comments =
          await _repository.getAllCommentsPost(postId, userId);
      return comments;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> setLikeComment({
    required String token,
    required String id,
    required bool isLiked,
  }) async {
    try {
      if (isLiked) {
        await _repository.likeComment(token: token, id: id);
      } else {
        await _repository.removeLikeComment(token: token, id: id);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteComment({
    required String token,
    required String id,
  }) async {
    try {
      await _repository.deleteComment(token: token, id: id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CommentModel> createComment(
      String content, String postId, String token) async {
    try {
      CommentModel comment =
          await _repository.createComment(content, postId, token);
      return comment;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
