// ignore: implementation_imports
import 'package:localization/src/localization_extension.dart';

class I18nConst {
  String get welcomeText => "weelcome-text".i18n();
  static String welcome(String a) => 'welcome-text'.i18n([a]);
}
