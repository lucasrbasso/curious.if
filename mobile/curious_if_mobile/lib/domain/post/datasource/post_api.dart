import 'dart:convert';
import 'package:http/http.dart';

import '../../../core/core.dart';

abstract class IPostApi {
  Future<String> listPosts({
    required String cursorID,
    required String takeValue,
  });
  Future<String> createPost({
    required String token,
    required String to,
    required String content,
  });
  void dispose();
}

class PostApi implements IPostApi {
  final Client client = Client();
  final String server = UtilsConst.server;

  @override
  void dispose() {
    client.close();
  }

  @override
  Future<String> listPosts({
    required String cursorID,
    required String takeValue,
  }) async {
    String? cursor = "cursor=$cursorID";
    String take = "take=$takeValue";
    try {
      final Response response = await client.get(
        Uri.parse(server + "api/posts/?$cursor&$take"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      ).timeout(const Duration(seconds: 10));
      return responseErrorStatusCode(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> createPost({
    required String token,
    required String to,
    required String content,
  }) async {
    try {
      final Response response = await client
          .post(Uri.parse(server + "api/posts/"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'Bearer $token'
              },
              body: json.encode(<String, String>{'content': content, 'to': to}))
          .timeout(const Duration(seconds: 10));
      return responseErrorStatusCode(response);
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
