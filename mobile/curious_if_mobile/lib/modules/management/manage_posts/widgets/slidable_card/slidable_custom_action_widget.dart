import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const int _kFlex = 1;
const Color _kBackgroundColor = Colors.white;
const bool _kAutoClose = true;

class SlidableCustomActionWidget extends StatelessWidget {
  const SlidableCustomActionWidget({
    Key? key,
    this.flex = _kFlex,
    this.backgroundColor = _kBackgroundColor,
    this.foregroundColor,
    this.autoClose = _kAutoClose,
    required this.onPressed,
    this.icon,
    this.spacing = 4,
    this.label,
    this.sizeIcon,
    this.style,
  })  : assert(flex > 0),
        assert(icon != null || label != null),
        super(key: key);

  final int flex;
  final Color backgroundColor;
  final Color? foregroundColor;
  final bool autoClose;
  final SlidableActionCallback? onPressed;
  final IconData? icon;
  final double spacing;
  final String? label;
  final double? sizeIcon;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    if (icon != null) {
      children.add(
        Icon(icon, size: sizeIcon),
      );
    }

    if (label != null) {
      if (children.isNotEmpty) {
        children.add(
          SizedBox(height: spacing),
        );
      }

      children.add(
        Text(
          label!,
          overflow: TextOverflow.ellipsis,
          style: style,
        ),
      );
    }

    final child = children.length == 1
        ? children.first
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...children.map(
                (child) => Flexible(
                  child: child,
                ),
              )
            ],
          );

    return CustomSlidableAction(
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(10),
      autoClose: autoClose,
      padding: EdgeInsets.zero,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      flex: flex,
      child: child,
    );
  }
}
