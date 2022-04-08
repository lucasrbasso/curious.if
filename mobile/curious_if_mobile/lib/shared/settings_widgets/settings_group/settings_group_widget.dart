import 'package:flutter/material.dart';
import '/core/core.dart';
import 'package:sizer/sizer.dart';

class SettingsGroup extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;
  final TextStyle? style;
  final bool hasDivider;
  final String? tooltip;

  const SettingsGroup({
    Key? key,
    required this.title,
    this.subtitle,
    required this.children,
    this.style,
    this.hasDivider = true,
    this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var elements = <Widget>[
      Container(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 22.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                title.toUpperCase(),
                style: groupStyle(context),
              ),
              if (tooltip != null)
                Tooltip(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  margin: EdgeInsets.symmetric(horizontal: 15.w),
                  triggerMode: TooltipTriggerMode.tap,
                  message: tooltip,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.info,
                        color: AppTheme.colors.bodyTitleSettings),
                  ),
                ),
            ],
          ),
        ),
      ),
    ];

    if (subtitle != null) {
      elements.addAll([
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Align(alignment: Alignment.centerLeft, child: Text(subtitle!)),
        ),
      ]);
    }

    elements.add(const SizedBox(
      height: 14,
    ));

    elements.addAll(children);

    if (hasDivider) {
      elements.add(
        Divider(
          color: AppTheme.colors.bodyDividerSettings,
          thickness: 1,
        ),
      );
    }

    return Wrap(
      children: <Widget>[
        Column(
          children: elements,
        )
      ],
    );
  }

  TextStyle groupStyle(BuildContext context) {
    return style ??
        TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        );
  }
}
