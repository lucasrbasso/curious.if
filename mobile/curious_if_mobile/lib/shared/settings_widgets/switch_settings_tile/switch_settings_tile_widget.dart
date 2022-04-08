import 'package:flutter/material.dart';
import '/core/core.dart';
import 'package:sizer/sizer.dart';

class SwitchSettingsTileWidget extends StatefulWidget {
  final Function(bool) onChanged;
  final String title;
  final bool switchValue;
  final TextStyle style;
  final Widget leading;
  final bool hasDivider;
  const SwitchSettingsTileWidget({
    Key? key,
    required this.onChanged,
    required this.title,
    required this.switchValue,
    required this.style,
    required this.leading,
    this.hasDivider = true,
  }) : super(key: key);

  @override
  _SwitchSettingsTileWidgetState createState() =>
      _SwitchSettingsTileWidgetState();
}

class _SwitchSettingsTileWidgetState extends State<SwitchSettingsTileWidget> {
  bool switchValue = true;
  @override
  void initState() {
    switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double borderWidth = 0.3.w;
    return Column(
      children: [
        SwitchListTile(
          secondary: widget.leading,
          activeColor: AppTheme.colors.bodySwitchSettings,
          inactiveThumbColor: AppTheme.colors.bodyDesactiveSwitchSettings,
          title: Text(
            widget.title,
            style: widget.style,
          ),
          onChanged: (value) {
            switchValue = value;
            widget.onChanged(value);
            if (mounted) {
              setState(() {});
            }
          },
          value: switchValue,
        ),
        if (widget.hasDivider)
          Divider(
            color: AppTheme.colors.bodyDividerSettings,
            thickness: borderWidth,
          ),
      ],
    );
  }
}
