import 'dart:convert';
import 'package:http/http.dart' show Client;

import '../../../core/core.dart';
import '../model/post_model.dart';

abstract class IPostApi {
  Future<String> listPosts(String? lastID);
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
  Future<String> listPosts(String? lastID) async {
    try {
      final response = await client
          .post(
            Uri.parse(server + "auth/login/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer dasdasdasdas'
            },
            body: lastID != null
                ? jsonEncode(<String, String>{
                    'lastID': lastID,
                  })
                : null,
          )
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400) {
        throw json.decode(response.body);
      } else {
        throw "Erro na conexão da API (Status: ${response.statusCode})";
      }
    } catch (e) {
      rethrow;
    }
  }
}
