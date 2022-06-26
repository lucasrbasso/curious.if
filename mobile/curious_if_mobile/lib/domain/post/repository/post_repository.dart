import 'dart:developer';

import '../datasource/post_api.dart';
import '../model/post_model.dart';

abstract class IPostRepository {
  Future<List<PostModel>> listPosts({
    required String cursorID,
    required String takeValue,
    String? id,
  });
  Future<PostModel> createPost({
    required String token,
    required String to,
    required String content,
  });
  Future<void> likePost({
    required String token,
    required String id,
  });

  Future<void> removeLikePost({
    required String token,
    required String id,
  });
  void dispose();
}

class PostRepository implements IPostRepository {
  final IPostApi _datasource;

  PostRepository({IPostApi? datasource})
      : _datasource = datasource ?? PostApi();

  @override
  Future<List<PostModel>> listPosts({
    required String cursorID,
    required String takeValue,
    String? id,
  }) async {
    try {
      String response = await _datasource.listPosts(
          cursorID: cursorID, takeValue: takeValue, id: id);
      print("Aaa");
      print(response);
      print("Aaa");
      List<PostModel> posts = PostModel.fromJsonList(response);
      return posts;
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  @override
  Future<PostModel> createPost({
    required String token,
    required String to,
    required String content,
  }) async {
    try {
      String response =
          await _datasource.createPost(to: to, content: content, token: token);

      PostModel post = PostModel.fromJson(response);
      return post;
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  @override
  Future<void> likePost({
    required String token,
    required String id,
  }) async {
    try {
      String response = await _datasource.likePost(id: id, token: token);
      log(response);
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  @override
  @override
  Future<void> removeLikePost({
    required String token,
    required String id,
  }) async {
    try {
      String response = await _datasource.removeLikePost(id: id, token: token);
      log(response);
    } catch (e) {
      throw handleErrorReturn(e);
    }
  }

  Object handleErrorReturn(Object e) {
    print(e.toString());
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
