import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../shared/button_form_input/button_form_input.dart';
import '../../../../shared/text_form_input/text_form_input.dart';
import 'form_sign_up_controller.dart';

class FormSignUpWidget extends StatefulWidget {
  void Function(Object?) onSaved;
  FormSignUpWidget({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<FormSignUpWidget> createState() => _FormSignUpWidgetState();
}

class _FormSignUpWidgetState extends State<FormSignUpWidget> {
  final _formKey = GlobalKey<FormState>();
  final FormSignUpController controller = FormSignUpController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormInput(
            text: '',
            hintText: 'Nome',
            icon: Icon(Icons.person_outline,
                size: 22, color: AppTheme.colors.textField),
            validate: controller.validateName,
            onSaved: controller.savedName,
          ),
          const SizedBox(height: 8),
          TextFormInput(
            text: '',
            hintText: 'E-mail',
            icon: Icon(Icons.email_outlined,
                size: 22, color: AppTheme.colors.textField),
            validate: controller.validateEmail,
            onSaved: controller.savedEmail,
          ),
          const SizedBox(height: 8),
          TextFormInput(
            text: '',
            hintText: 'Senha',
            icon: Icon(Icons.lock_outline,
                size: 22, color: AppTheme.colors.textField),
            validate: controller.validatePassword,
            onSaved: controller.savedPassword,
            password: true,
          ),
          const SizedBox(height: 32),
          ButtonFormInput(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.onSaved(
                    [controller.email, controller.nome, controller.password]);
              }
            },
          ),
        ],
      ),
    );
  }
}
