import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/core/core.dart';

class TextFormCustom extends StatelessWidget {
  final Function(String)? onChanged;
  final String text;
  final String? label;
  final String? hintText;
  final TextAlign textAlign;
  final int? maxLength;
  final bool expands;
  final bool flexible;
  final bool divider;
  final bool disable;
  final bool disableForm;

  const TextFormCustom({
    Key? key,
    this.onChanged,
    required this.text,
    this.divider = true,
    this.disable = false,
    this.disableForm = false,
    this.flexible = false,
    this.textAlign = TextAlign.left,
    this.label,
    this.hintText,
    this.maxLength,
    this.expands = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle styleText;
    if (disableForm) {
      styleText = AppTheme.textStyles.textAlertDialog;
    } else if (disable) {
      styleText = AppTheme.textStyles.textAlertDialog;
    } else {
      styleText = AppTheme.textStyles.textAlertDialog;
    }

    InputBorder border = divider
        ? UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.colors.divider,
              width: 1,
            ),
          )
        : InputBorder.none;

    Widget textfield = TextFormField(
      readOnly: disable || disableForm,
      maxLength: maxLength,
      expands: expands,
      maxLines: null,
      textAlign: textAlign,
      initialValue: Bidi.stripHtmlIfNeeded(text.replaceAll("<br />", "\n")),
      keyboardType: TextInputType.multiline,
      style: styleText,
      cursorColor: AppTheme.colors.backgroundAlertDialogColor,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: styleText,
        hintText: hintText,
        isDense: true,
        hintStyle: disable
            ? AppTheme.textStyles.textAlertDialog
            : AppTheme.textStyles.textAlertDialog,
        border: InputBorder.none,
        enabledBorder: border,
        focusedBorder: border,
      ),
      onChanged: onChanged,
    );

    return flexible ? Flexible(child: textfield) : textfield;
  }
}
