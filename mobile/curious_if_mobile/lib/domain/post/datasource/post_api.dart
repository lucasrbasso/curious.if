import 'dart:convert';
import 'package:http/http.dart' show Client;

import '../../../core/core.dart';

abstract class IPostApi {
  Future<String> listPosts({
    required String token,
    required String cursorID,
    required String takeValue,
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
    required String token,
    required String cursorID,
    required String takeValue,
  }) async {
    String? cursor = "cursor=$cursorID";
    String take = "take=$takeValue";
    try {
      final response = await client.get(
        Uri.parse(server + "api/posts/?$cursor&$take"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400 ||
          response.statusCode == 401 ||
          response.statusCode == 404) {
        throw json.decode(response.body);
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      rethrow;
    }
  }
}
