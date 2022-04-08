import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/core.dart';
import '../simple_settings_tile/simple_settings_tile_widget.dart';

class DropDownSettingsTile<T> extends StatefulWidget {
  final T selected;
  final Map<T, String> values;
  final String title;

  final String subtitle;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final Widget leading;
  final AlignmentGeometry alignment;
  final bool enabled;
  final Function(T?)? onChanged;

  const DropDownSettingsTile({
    Key? key,
    required this.title,
    required this.selected,
    required this.values,
    this.enabled = true,
    this.onChanged,
    this.subtitle = '',
    required this.leading,
    this.alignment = AlignmentDirectional.centerEnd,
    this.titleTextStyle,
    this.subtitleTextStyle,
  }) : super(key: key);

  @override
  _DropDownSettingsTileState<T> createState() =>
      _DropDownSettingsTileState<T>();
}

class _DropDownSettingsTileState<T> extends State<DropDownSettingsTile<T>> {
  late T selectedValue;

  final GlobalKey _dropdownButtonKey = GlobalKey();
  @override
  void initState() {
    selectedValue = widget.selected;
    super.initState();
  }

  void openDropdown() {
    GestureDetector? detector;
    void searchForGestureDetector(BuildContext element) {
      element.visitChildElements((element) {
        if (element.widget is GestureDetector) {
          detector = element.widget as GestureDetector;
          return;
        } else {
          searchForGestureDetector(element);
        }
        return;
      });
    }

    searchForGestureDetector(_dropdownButtonKey.currentContext!);
    assert(detector != null);

    detector?.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    double borderWidth = 0.3.w;
    return Column(
      children: [
        SettingsTile(
          title: widget.title,
          subtitle: widget.subtitle,
          leading: widget.leading,
          enabled: widget.enabled,
          style: AppTheme.textStyles.bodyButtomTitleSettings,
          onTap: () {
            openDropdown();
          },
          child: _SettingsDropDown<T>(
            selected: selectedValue,
            dropdownButtonKey: _dropdownButtonKey,
            alignment: widget.alignment,
            values: widget.values.keys.toList().cast<T>(),
            onChanged: (newValue) {
              if (newValue != null) {
                selectedValue = newValue;
                setState(() {});
              }
              if (widget.onChanged != null) widget.onChanged!(newValue);
            },
            enabled: widget.enabled,
            itemBuilder: (T value) {
              return Text(
                widget.values[value]!,
                style: AppTheme.textStyles.bodyButtomTitleSettings,
              );
            },
          ),
        ),
        Divider(
          color: AppTheme.colors.bodyDividerSettings,
          thickness: borderWidth,
        ),
      ],
    );
  }
}

class _SettingsDropDown<T> extends StatelessWidget {
  /// value of the selected in this dropdown
  final T selected;
  final AlignmentGeometry alignment;
  final GlobalKey dropdownButtonKey;
  final List<T> values;
  final Function(T?)? onChanged;
  final Widget Function(T) itemBuilder;
  final bool enabled;

  const _SettingsDropDown({
    required this.selected,
    required this.values,
    required this.onChanged,
    required this.itemBuilder,
    required this.dropdownButtonKey,
    this.alignment = AlignmentDirectional.centerEnd,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.end,
      children: <Widget>[
        DropdownButton<T>(
          key: dropdownButtonKey,
          dropdownColor: AppTheme.colors.background,
          value: selected,
          alignment: alignment,
          onChanged: enabled ? onChanged : null,
          underline: Container(),
          items: values.map<DropdownMenuItem<T>>(
            (T val) {
              return DropdownMenuItem<T>(
                value: val,
                child: itemBuilder(val),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
