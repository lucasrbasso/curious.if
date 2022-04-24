import 'package:email_validator/email_validator.dart';

class FormSignUpController {
  String? name;
  String? email;
  String? password;

  String? validateName(String? value) {
    if ((value ?? "").isEmpty) {
      return 'Por favor insira um nome válido';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (!EmailValidator.validate(value ?? "")) {
      return 'Por favor insira um email válido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if ((value ?? "").length < 6) {
      return 'Por favor insira uma senha válida';
    }
    return null;
  }

  void savedName(String? value) => name = value;

  void savedEmail(String? value) => email = value;

  void savedPassword(String? value) => password = value;

  void printDados() {
    print(name);
    print(email);
    print(password);
  }
}
