import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/core.dart';

class ButtonFormInput extends StatelessWidget {
  final Function onTap;
  final String text;
  final bool isLoading;
  const ButtonFormInput({
    Key? key,
    required this.onTap,
    this.isLoading = false,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            height: 60,
            child: Center(
                child: CircularProgressIndicator(
              color: AppTheme.colors.backgroundButton,
            )))
        : Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                      backgroundColor: MaterialStateProperty.all(
                          AppTheme.colors.backgroundButton)),
                  onPressed: () => onTap(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      text,
                      style: AppTheme.textStyles.textButtonInput,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
