import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../../i18n/i18n_const.dart';
import '../../shared/settings_widgets/alert_dialog_settings/alert_dialog_settings.dart';
import '../../shared/settings_widgets/card_perfil/card_perfil_widget.dart';
import '../../shared/settings_widgets/drop_down_settings_tile/drop_down_settings_tile.dart';
import '../../shared/settings_widgets/icon_widget/icon_widget.dart';
import '../../shared/settings_widgets/settings_group/settings_group_widget.dart';
import '../../shared/settings_widgets/simple_settings_tile/simple_settings_tile_widget.dart';
import '../../shared/settings_widgets/switch_settings_tile/switch_settings_tile_widget.dart';
import '/core/core.dart';
import '/modules/settings/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late AppThemeController controllerTheme;
  late SettingsController settingsController;

  @override
  void initState() {
    controllerTheme = AppThemeController();
    settingsController = SettingsController();
    settingsController.autoRun(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: controllerTheme.isDarkMode
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppTheme.colors.bodyBackgroundSettings,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(3.h),
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      tooltip: I18nConst.quit,
                      iconSize: 24.sp,
                      padding: EdgeInsets.zero,
                      color: AppTheme.colors.appBarTitleSettings,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 32.sp,
                          child: Text(
                            I18nConst.configs,
                            style: AppTheme.textStyles.appBarTitleSettings,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24.sp,
                    )
                  ],
                ),
              ),
              CardPerfilWidget(
                callback: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialogSettings(
                    yesPress: () => Navigator.maybePop(context),
                  ),
                ),
              ),
              SwitchSettingsTileWidget(
                leading: IconWidget(
                  color: AppTheme.colors.bodyIconColorSettings,
                  icon: Icons.dark_mode,
                  backgroundColor: const Color(0xFF794BF6),
                ),
                title: I18nConst.darkMode,
                style: AppTheme.textStyles.bodyButtomTitleSettings,
                onChanged: (value) {
                  if (value) {
                    controllerTheme.setThemeMode(ThemeMode.dark);
                  } else {
                    controllerTheme.setThemeMode(ThemeMode.light);
                  }
                },
                switchValue: controllerTheme.themeMode == ThemeMode.dark,
              ),
              SizedBox(height: 2.h),
              DropDownSettingsTile<String>(
                selected: settingsController.locale,
                title: I18nConst.languageApp,
                values: {
                  'es': I18nConst.spanish,
                  'en': I18nConst.english,
                  'pt': I18nConst.portuguese,
                },
                leading: IconWidget(
                  color: AppTheme.colors.bodyIconColorSettings,
                  icon: Icons.language_outlined,
                  backgroundColor: Colors.pinkAccent,
                ),
                onChanged: (value) async =>
                    await settingsController.setLocale(value),
              ),
              SizedBox(height: 2.5.h),
              SettingsGroup(
                title: I18nConst.general,
                style: AppTheme.textStyles.bodyTitleSettings,
                children: [
                  SimpleSettingsTile(
                    title: I18nConst.logout,
                    subtitle: "",
                    style: AppTheme.textStyles.bodyButtomTitleSettings,
                    leading: IconWidget(
                      color: AppTheme.colors.bodyIconColorSettings,
                      icon: Icons.logout,
                      backgroundColor: Colors.blueAccent,
                    ),
                    onTap: () => settingsController.signOutGoogle(
                      () => settingsController.navigationLogin(context),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 1.5.h),
              SettingsGroup(
                title: I18nConst.feedback,
                style: AppTheme.textStyles.bodyTitleSettings,
                children: [
                  SimpleSettingsTile(
                    title: I18nConst.reportBug,
                    subtitle: "",
                    style: AppTheme.textStyles.bodyButtomTitleSettings,
                    leading: IconWidget(
                      color: AppTheme.colors.bodyIconColorSettings,
                      icon: Icons.bug_report,
                      backgroundColor: Colors.teal,
                    ),
                    onTap: () async {},
                  ),
                  SizedBox(height: 1.5.h),
                  SimpleSettingsTile(
                    title: I18nConst.sendFeedback,
                    subtitle: "",
                    style: AppTheme.textStyles.bodyButtomTitleSettings,
                    leading: IconWidget(
                      color: AppTheme.colors.bodyIconColorSettings,
                      icon: Icons.thumb_up_alt_sharp,
                      backgroundColor: Colors.purple,
                    ),
                    onTap: () async {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
