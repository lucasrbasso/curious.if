import 'dart:convert';
import 'package:http/http.dart' show Client;

import '../../../core/core.dart';

abstract class ICommentApi {
  Future<String> createComment(String content, String postId);
  Future<String> getAllCommentsPost(String postId);
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
  Future<String> createComment(String content, String postId) async {
    try {
      final response = await client
          .post(
            Uri.parse(server + "api/comments/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
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
  Future<String> getAllCommentsPost(String postId) async {
    try {
      print(postId);
      final response = await client.get(
        Uri.parse(server + "api/comments/post/$postId"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 10));

      print(response.body);
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
}
