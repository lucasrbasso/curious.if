import 'dart:convert';
import 'package:curious_if_mobile/domain/signup/datasource/sign_up_api.dart';
import '../model/sign_up_model.dart';

abstract class ISignUpRepository {
  Future<String> signUp(SignUpModel signUpModel);
  void dispose();
}

class SignUpRepository implements ISignUpRepository {
  final ISignUpApi _datasource;

  SignUpRepository({ISignUpApi? datasource})
      : _datasource = datasource ?? SignUpApi();

  @override
  Future<String> signUp(SignUpModel signUpModel) async {
    try {
      String response = await _datasource.signUp(signUpModel);
      Map<String, dynamic> responseMap = jsonDecode(response);
      if (responseMap["email"] is String) {
        return responseMap["email"];
      } else {
        return "";
      }
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
