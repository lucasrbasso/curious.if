import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '/core/core.dart';

class ButtonBottomBarWidget extends StatefulWidget {
  final bool expanded;
  final String label;
  final VoidCallback onPressed;
  const ButtonBottomBarWidget({
    Key? key,
    required this.label,
    this.expanded = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ButtonBottomBarWidgetState createState() => _ButtonBottomBarWidgetState();
}

class _ButtonBottomBarWidgetState extends State<ButtonBottomBarWidget> {
  late Widget buttonBottomBarWidget;
  @override
  void initState() {
    double borderWidth = 0.3.w;
    buttonBottomBarWidget = InkWell(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        widget.onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: AppTheme.colors.border, width: borderWidth)),
        ),
        child: Center(
          child: Text(
            widget.label,
            style: AppTheme.textStyles.textButton,
          ),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.expanded
        ? Expanded(child: buttonBottomBarWidget)
        : buttonBottomBarWidget;
  }
}
