class FormCreatePostController {
  String? name;
  String? message;
  String? validateName(String? value) {
    return null;
  }

  String? validateMessage(String? value) {
    if ((value ?? "").isEmpty) {
      return 'Por favor insira uma mensagem válida';
    }
    return null;
  }

  void savedNome(String? value) => name = value;

  void savedMessage(String? value) => message = value;

  void printDados() {
    print(name);
    print(message);
  }
}
