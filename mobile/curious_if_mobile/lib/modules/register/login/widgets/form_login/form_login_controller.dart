import 'package:email_validator/email_validator.dart';

class FormLoginController {
  String? email;
  String? password;
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

  void savedEmail(String? value) => email = value;

  void savedPassword(String? value) => password = value;

  void printDados() {
    print(email);
    print(password);
  }
}
