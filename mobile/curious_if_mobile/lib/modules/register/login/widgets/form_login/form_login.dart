import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../../shared/button_form_input/button_form_input.dart';
import '../../../../../shared/text_form_input/text_form_input.dart';
import 'form_login_controller.dart';

class FormLoginWidget extends StatefulWidget {
  final String initialEmail;
  final Future Function(Map<String, dynamic>) onSaved;
  const FormLoginWidget({
    Key? key,
    required this.initialEmail,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<FormLoginWidget> createState() => _FormLoginWidgetState();
}

class _FormLoginWidgetState extends State<FormLoginWidget> {
  final _formKey = GlobalKey<FormState>();
  final FormLoginController controller = FormLoginController();
  bool isLoading = false;

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
            text: '',
            disable: isLoading,
            hintText: 'Senha',
            icon: Icon(Icons.lock_outline,
                size: 22, color: AppTheme.colors.textField),
            validate: controller.validatePassword,
            onSaved: controller.savedPassword,
            password: true,
          ),
          const SizedBox(height: 48),
          ButtonFormInput(
            isLoading: isLoading,
            text: "Login",
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                isLoading = true;
                if (mounted) setState(() {});
                await widget.onSaved({
                  "email": controller.email,
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
          const SizedBox(height: 8),
          Text(
            "Ainda não possui uma conta?",
            style: AppTheme.textStyles.subtitleOpacity,
            textAlign: TextAlign.center,
          ),
          InkWell(
            onTap: () {
              _formKey.currentState!.save();
              Navigator.pushNamed(context, RouterClass.signUp, arguments: {
                "email": controller.email,
                "password": controller.password
              });
              controller.email = null;
              controller.password = null;
            },
            child: Text(
              "Cadastre-se",
              style: AppTheme.textStyles.subtitleButton,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
