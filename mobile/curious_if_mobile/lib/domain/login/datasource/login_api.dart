import 'dart:convert';
import 'package:http/http.dart' show Client;

import '../../../core/core.dart';
import '../model/login_model.dart';

abstract class ILoginApi {
  Future<String> login(LoginModel loginModel);
  void dispose();
}

class LoginApi implements ILoginApi {
  final Client client = Client();
  final String server = UtilsConst.server;

  @override
  void dispose() {
    client.close();
  }

  @override
  Future<String> login(LoginModel loginModel) async {
    try {
      final response = await client
          .post(
            Uri.parse(server + "auth/login/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': loginModel.email,
              'password': loginModel.password,
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
}
