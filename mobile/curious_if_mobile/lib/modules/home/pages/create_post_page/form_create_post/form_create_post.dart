import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../../../shared/button_form_input/button_form_input.dart';
import '../../../../../shared/text_form_input/text_form_input.dart';
import 'form_create_post_controller.dart';

class FormCreatePostWidget extends StatefulWidget {
  final Future Function(Map<String, dynamic>) onSaved;
  const FormCreatePostWidget({
    Key? key,
    required this.onSaved,
  }) : super(key: key);

  @override
  State<FormCreatePostWidget> createState() => _FormCreatePostWidgetState();
}

class _FormCreatePostWidgetState extends State<FormCreatePostWidget> {
  final _formKey = GlobalKey<FormState>();
  final FormCreatePostController controller = FormCreatePostController();
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
            text: '',
            disable: isLoading,
            hintText: 'Nome e curso',
            validate: controller.validateName,
            onSaved: controller.savedNome,
          ),
          const SizedBox(height: 24),
          TextFormInput(
            text: '',
            disable: isLoading,
            hintText: 'Digite sua mensagem...',
            validate: controller.validateMessage,
            onSaved: controller.savedMessage,
            maxLines: 6,
          ),
          const SizedBox(height: 48),
          ButtonFormInput(
            isLoading: isLoading,
            text: "Enviar",
            onTap: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                isLoading = true;
                if (mounted) setState(() {});
                await widget.onSaved(
                    {"name": controller.name, "message": controller.message});
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
