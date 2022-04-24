import 'dart:convert';
import 'package:http/http.dart' show Client;

import '../../../core/core.dart';
import '../model/sign_up_model.dart';

abstract class ISignUpApi {
  Future<String> signUp(SignUpModel signUpModel);
  void dispose();
}

class SignUpApi implements ISignUpApi {
  final Client client = Client();
  final String server = UtilsConst.server;

  @override
  void dispose() {
    client.close();
  }

  @override
  Future<String> signUp(SignUpModel signUpModel) async {
    try {
      final response = await client
          .post(
            Uri.parse(server + "api/users/"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'name': signUpModel.name,
              'password': signUpModel.password,
              'email': signUpModel.email
            }),
          )
          .timeout(const Duration(seconds: 10));
      print(response.body);
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
