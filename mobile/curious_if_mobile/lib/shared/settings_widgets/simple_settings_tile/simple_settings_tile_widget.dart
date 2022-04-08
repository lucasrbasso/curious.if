import 'package:flutter/material.dart';

import '/core/core.dart';

class SimpleSettingsTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget leading;
  final bool enabled;
  final Widget? child;
  final VoidCallback onTap;
  final TextStyle? style;

  const SimpleSettingsTile({
    Key? key,
    required this.title,
    this.subtitle = "",
    this.child,
    this.enabled = true,
    required this.leading,
    required this.onTap,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      enabled: enabled,
      onTap: () => _handleTap(context),
      child: child != null ? getIcon(context) : const Text(''),
      style: style,
    );
  }

  Widget getIcon(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.navigate_next,
        color: AppTheme.colors.bodyTitleSettings,
      ),
      onPressed: enabled ? () => _handleTap(context) : null,
    );
  }

  void _handleTap(BuildContext context) {
    onTap.call();

    if (child != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => child!,
      ));
    }
  }
}

class SettingsTile extends StatefulWidget {
  final String title;
  final Widget leading;
  final String subtitle;
  final bool enabled;
  final Widget child;
  final GestureTapCallback? onTap;
  final bool showChildBelow;
  final TextStyle? style;

  const SettingsTile({
    Key? key,
    required this.title,
    required this.leading,
    this.subtitle = '',
    this.enabled = true,
    required this.child,
    this.onTap,
    this.showChildBelow = false,
    this.style,
  }) : super(key: key);

  @override
  _SettingsTileState createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ListTile(
            leading: widget.leading,
            title: Text(
              widget.title,
              style: widget.style,
            ),
            subtitle: widget.subtitle.isEmpty
                ? null
                : Text(
                    widget.subtitle,
                  ),
            enabled: widget.enabled,
            onTap: widget.onTap,
            trailing: Visibility(
              visible: !widget.showChildBelow,
              child: widget.child,
            ),
            dense: true,
          ),
          Visibility(
            visible: widget.showChildBelow,
            child: widget.child,
          ),
        ],
      ),
    );
  }
}
