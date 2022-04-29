import '../model/sign_up_model.dart';
import '../repository/sign_up_repository.dart';

abstract class ISignUpUseCase {
  Future<String> signUp(SignUpModel signUpModel);
  void dispose();
}

class SignUpUseCase implements ISignUpUseCase {
  final ISignUpRepository _repository;

  SignUpUseCase({ISignUpRepository? repository})
      : _repository = repository ?? SignUpRepository();

  @override
  Future<String> signUp(SignUpModel signUpModel) async {
    try {
      String email = await _repository.signUp(signUpModel);
      return email;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
