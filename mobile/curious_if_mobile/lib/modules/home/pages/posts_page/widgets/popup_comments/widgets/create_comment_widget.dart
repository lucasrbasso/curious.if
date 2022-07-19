import 'package:flutter/material.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../shared/text_form_input/text_form_input.dart';

class CreateCommentWidget extends StatefulWidget {
  final Future<bool> Function(String) onSaved;

  const CreateCommentWidget({Key? key, required this.onSaved})
      : super(key: key);

  @override
  State<CreateCommentWidget> createState() => _CreateCommentWidgetState();
}

class _CreateCommentWidgetState extends State<CreateCommentWidget> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: TextFormInput(
              onSaved: (value) async {
                loading = true;
                error = '';
                setState(() {});
                bool result = await widget.onSaved(value ?? '');
                if (!result) {
                  error = "Erro ao enviar a mensagem";
                } else {
                  _formKey.currentState?.reset();
                }

                loading = false;
                setState(() {});
              },
              contentPadding: EdgeInsets.only(left: 12, bottom: 4, top: 12),
              validate: (value) {
                if ((value ?? "").trim().isEmpty) {
                  return 'Por favor uma mensagem válida';
                }
                return null;
              },
              text: '',
              hintText: 'Escreva um comentário...',
              maxLines: 4,
              minLines: 1,
              suffixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (loading) ...[
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: AppTheme.colors.backgroundButton,
                      ),
                    )
                  ] else ...[
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (mounted) {
                              setState(() {
                                FocusScope.of(context).unfocus();
                              });
                            }
                          }
                        },
                        child: Ink(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.send,
                            color: AppTheme.colors.backgroundButton,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (error.trim().isNotEmpty) ...[
            SizedBox(height: 4),
            Text(
              error,
              style:
                  AppTheme.textStyles.textSnackBar.copyWith(color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }
}
