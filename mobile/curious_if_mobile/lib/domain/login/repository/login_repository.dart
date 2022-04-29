import '../datasource/login_api.dart';
import '../model/login_model.dart';
import '../model/user_model.dart';

abstract class ILoginRepository {
  Future<UserModel> login(LoginModel loginModel);
  void dispose();
}

class LoginRepository implements ILoginRepository {
  final ILoginApi _datasource;

  LoginRepository({ILoginApi? datasource})
      : _datasource = datasource ?? LoginApi();

  @override
  Future<UserModel> login(LoginModel loginModel) async {
    try {
      String response = await _datasource.login(loginModel);
      UserModel userModel = UserModel.fromJson(response);
      return userModel;
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
