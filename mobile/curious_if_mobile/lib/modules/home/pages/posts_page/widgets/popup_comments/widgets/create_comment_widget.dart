import 'package:flutter/material.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../shared/text_form_input/text_form_input.dart';

class CreateCommentWidget extends StatelessWidget {
  const CreateCommentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextFormInput(
        contentPadding: EdgeInsets.only(left: 12, bottom: 4, top: 12),
        text: '',
        hintText: 'Escreva um comentário...',
        maxLines: 4,
        minLines: 1,
        suffixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {},
                child: Ink(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.send,
                    color: AppTheme.colors.backgroundButton,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
