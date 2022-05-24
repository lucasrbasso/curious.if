import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../../shared/button_form_input/button_form_input.dart';
import '../../../../../shared/text_form_input/text_form_input.dart';
import 'form_sign_up_controller.dart';

class FormSignUpWidget extends StatefulWidget {
  final Future Function(Map<String, dynamic>) onSaved;
  final String initialEmail;
  final String initialPassword;
  const FormSignUpWidget({
    Key? key,
    required this.onSaved,
    required this.initialEmail,
    required this.initialPassword,
  }) : super(key: key);

  @override
  State<FormSignUpWidget> createState() => _FormSignUpWidgetState();
}

class _FormSignUpWidgetState extends State<FormSignUpWidget> {
  final _formKey = GlobalKey<FormState>();
  final FormSignUpController controller = FormSignUpController();
  bool isLoading = false;
  Future? onTapCancel;

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormInput(
            text: '',
            disable: isLoading,
            hintText: 'Nome',
            icon: Icon(Icons.person_outline,
                size: 22, color: AppTheme.colors.textField),
            validate: controller.validateName,
            onSaved: controller.savedName,
          ),
          const SizedBox(height: 8),
          TextFormInput(
            text: widget.initialEmail,
            disable: isLoading,
            hintText: 'E-mail',
            icon: Icon(Icons.email_outlined,
                size: 22, color: AppTheme.colors.textField),
            validate: controller.validateEmail,
            onSaved: controller.savedEmail,
          ),
          const SizedBox(height: 8),
          TextFormInput(
            text: widget.initialPassword,
            disable: isLoading,
            hintText: 'Senha',
            icon: Icon(Icons.lock_outline,
                size: 22, color: AppTheme.colors.textField),
            validate: controller.validatePassword,
            onSaved: controller.savedPassword,
            password: true,
          ),
          const SizedBox(height: 32),
          ButtonFormInput(
            isLoading: isLoading,
            text: "Cadastrar",
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                isLoading = true;
                if (mounted) setState(() {});
                onTapCancel = await widget.onSaved({
                  "email": controller.email,
                  "name": controller.name,
                  "password": controller.password
                });
                isLoading = false;

                if (mounted) {
                  setState(() {
                    FocusScope.of(context).unfocus();
                  });
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
