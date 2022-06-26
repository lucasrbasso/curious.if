import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/core.dart';

class TextFormInput extends StatefulWidget {
  final String? Function(String?)? validate;
  final Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final Widget? icon;

  final Widget? suffixIcon;

  final Widget? suffix;
  final String text;
  final String? label;
  final String? hintText;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final EdgeInsets? contentPadding;
  final Color? focusedBorderColor;
  final int? maxLength;
  final int? maxLines;

  final int? minLines;
  final bool expands;
  final bool flexible;
  final bool divider;
  final bool disable;
  final bool disableForm;
  final bool password;

  const TextFormInput({
    Key? key,
    this.validate,
    this.onChanged,
    this.onSaved,
    this.icon,
    this.suffixIcon,
    this.suffix,
    required this.text,
    this.label,
    this.hintText,
    this.textAlign = TextAlign.left,
    this.textStyle,
    this.contentPadding,
    this.focusedBorderColor,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.flexible = false,
    this.divider = true,
    this.disable = false,
    this.disableForm = false,
    this.password = false,
  }) : super(key: key);

  @override
  State<TextFormInput> createState() => _TextFormInputState();
}

class _TextFormInputState extends State<TextFormInput> {
  late bool _passwordVisible;
  bool validator = true;

  TextStyle get styleText {
    if (widget.disableForm) {
      return AppTheme.textStyles.textFieldInput;
    } else if (widget.disable) {
      return AppTheme.textStyles.textFieldInput;
    } else {
      return AppTheme.textStyles.textFieldInput;
    }
  }

  InputBorder get border => widget.divider
      ? OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppTheme.colors.backgroundTextForm,
            width: 1,
          ),
        )
      : InputBorder.none;

  @override
  void initState() {
    _passwordVisible = widget.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget textfield = RawScrollbar(
        thumbColor: AppTheme.colors.text,
        radius: Radius.circular(20),
        thickness: 5,
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          readOnly: widget.disable || widget.disableForm,
          maxLength: widget.maxLength,
          expands: widget.expands,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          textAlign: widget.textAlign,
          obscureText: _passwordVisible,
          enableSuggestions: !widget.password,
          autocorrect: !widget.password,
          initialValue:
              Bidi.stripHtmlIfNeeded(widget.text.replaceAll("<br />", "\n")),
          keyboardType: (widget.maxLines ?? 2) > 1
              ? TextInputType.multiline
              : TextInputType.text,
          style: widget.textStyle ?? styleText,
          cursorColor: AppTheme.colors.backgroundAlertDialogColor,
          decoration: InputDecoration(
            labelText: widget.label,
            hoverColor: Colors.white,
            fillColor: AppTheme.colors.backgroundTextForm,
            filled: true,
            labelStyle: widget.textStyle ?? styleText,
            prefixIcon: widget.icon,
            suffix: widget.suffix,
            hintText: widget.hintText,
            isDense: true,
            hintStyle: widget.disable
                ? AppTheme.textStyles.textHintFieldInput
                : AppTheme.textStyles.textHintFieldInput,
            border: border,
            contentPadding: widget.contentPadding,
            enabledBorder: border,
            focusedBorder: border.copyWith(
                borderSide: border.borderSide
                    .copyWith(color: widget.focusedBorderColor)),
            suffixIcon: !widget.password
                ? widget.suffixIcon
                : Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashRadius: 24,
                      onPressed: () {
                        _passwordVisible = !_passwordVisible;
                        setState(() {});
                      },
                      icon: Icon(_passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      color: AppTheme.colors.textField,
                    ),
                  ),
          ),
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          validator: widget.validate,
        ));

    return widget.flexible ? Flexible(child: textfield) : textfield;
  }
}
