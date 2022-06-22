import '../datasource/comment_api.dart';
import '../model/comment_model.dart';

abstract class ICommentRepository {
  Future<CommentModel> createComment(
      String content, String postId, String token);
  Future<List<CommentModel>> getAllCommentsPost(String postId);
  void dispose();
}

class CommentRepository implements ICommentRepository {
  final ICommentApi _datasource;

  CommentRepository({ICommentApi? datasource})
      : _datasource = datasource ?? CommentApi();

  @override
  Future<List<CommentModel>> getAllCommentsPost(String postId) async {
    try {
      String response = await _datasource.getAllCommentsPost(postId);
      List<CommentModel> comments = CommentModel.fromJsonList(response);
      return comments;
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  @override
  Future<CommentModel> createComment(
      String content, String postId, String token) async {
    try {
      String response = await _datasource.createComment(content, postId, token);
      CommentModel comment = CommentModel.fromJson(response);
      return comment;
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  Object handleErrorReturn(Object e) {
    if (e is String) {
      return e;
    } else if (e is Map<String, dynamic>) {
      if (e["message"] is String) {
        throw e["message"];
      } else if (e["message"] is List) {
        List errors = e["message"];
        String error = "";
        for (var element in errors) {
          Map<String, dynamic> errorMap = element["constraints"];
          errorMap.forEach((key, value) {
            error += value + "\n";
          });
        }
        throw error;
      } else {
        throw "Internal error";
      }
    }
    return e;
  }

  @override
  void dispose() {
    _datasource.dispose();
  }
}
