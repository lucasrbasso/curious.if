import '../model/login_model.dart';
import '../model/user_model.dart';
import '../repository/login_repository.dart';

abstract class ILoginUseCase {
  Future<UserModel> login(LoginModel loginModel);
  void dispose();
}

class LoginUseCase implements ILoginUseCase {
  final ILoginRepository _repository;

  LoginUseCase({ILoginRepository? repository})
      : _repository = repository ?? LoginRepository();

  @override
  Future<UserModel> login(LoginModel loginModel) async {
    try {
      UserModel user = await _repository.login(loginModel);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
