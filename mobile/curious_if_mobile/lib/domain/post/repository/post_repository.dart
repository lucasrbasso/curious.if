import '../datasource/post_api.dart';
import '../model/post_model.dart';

abstract class IPostRepository {
  Future<List<PostModel>> listPosts({
    required String token,
    required String cursorID,
    required String takeValue,
  });
  void dispose();
}

class PostRepository implements IPostRepository {
  final IPostApi _datasource;

  PostRepository({IPostApi? datasource})
      : _datasource = datasource ?? PostApi();

  @override
  Future<List<PostModel>> listPosts({
    required String token,
    required String cursorID,
    required String takeValue,
  }) async {
    try {
      String response = await _datasource.listPosts(
          cursorID: cursorID, takeValue: takeValue, token: token);

      List<PostModel> posts = PostModel.fromJsonList(response);
      return posts;
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
