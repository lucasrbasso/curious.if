import 'dart:convert';
import 'package:http/http.dart' show Client, Response;

import '../../../core/core.dart';

abstract class ICommentApi {
  Future<String> createComment(String content, String postId, String token);
  Future<String> getAllCommentsPost(String postId, String? userId);

  Future<String> likeComment({
    required String token,
    required String id,
  });
  Future<String> removeLikeComment({
    required String token,
    required String id,
  });

  Future<String> deleteComment({
    required String token,
    required String id,
  });
  void dispose();
}

class CommentApi implements ICommentApi {
  final Client client = Client();
  final String server = UtilsConst.server;

  @override
  void dispose() {
    client.close();
  }

  @override
  Future<String> likeComment({
    required String token,
    required String id,
  }) async {
    try {
      final Response response = await client.post(
        Uri.parse("${server}api/comments/like/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 10));
      return responseErrorStatusCode(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> deleteComment({
    required String token,
    required String id,
  }) async {
    try {
      final Response response = await client.delete(
        Uri.parse("${server}api/comments/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 10));
      return responseErrorStatusCode(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> removeLikeComment({
    required String token,
    required String id,
  }) async {
    try {
      final Response response = await client.delete(
        Uri.parse("${server}api/comments/like/$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 10));
      return responseErrorStatusCode(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> createComment(
      String content, String postId, String token) async {
    try {
      final response = await client
          .post(
            Uri.parse(server + "api/comments/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token'
            },
            body: jsonEncode(<String, String>{
              'content': content,
              'postId': postId,
            }),
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw json.decode(response.body);
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> getAllCommentsPost(String postId, String? userId) async {
    try {
      final response = await client.get(
        Uri.parse(server + "api/comments/post/$postId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user_id': userId ?? ''
        },
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        throw json.decode(response.body);
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      rethrow;
    }
  }

  String responseErrorStatusCode(Response response) {
    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 403 ||
        response.statusCode == 404) {
      throw json.decode(response.body);
    } else {
      throw "Erro na conexão da API (Status: ${response.statusCode})";
    }
  }
}
