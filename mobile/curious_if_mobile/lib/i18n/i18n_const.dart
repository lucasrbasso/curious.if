// ignore: implementation_imports
import 'package:localization/src/localization_extension.dart';

class I18nConst {
  static String get textLogin => "text-login".i18n();
  static String get textButtonGoogle => "text-button-google".i18n();
  static String get textButtonApple => "text-button-apple".i18n();
  static String get textTooltipApple => "text-tooltip-apple".i18n();
  static String get textTooltipGoogle => "text-tooltip-google".i18n();
  static String get erroConfigApp => "erro-config-app".i18n();
  static String get loginNull => "login-null".i18n();
  static String get loginNotFound => "login-not-found".i18n();
  static String get addIcon => "add-icon".i18n();
  static String get title => "title".i18n(); //
  static String get createIn => "create-in".i18n();
  static String get deletedItemSuccess => "deleted-item-success".i18n();
  static String get deletedItemFailed => "deleted-item-failed".i18n();
  static String get menuAbout => "menu-about".i18n();
  static String get menuSettings => "menu-settings".i18n();
  static String get menuLogout => "menu-logout".i18n();
  static String get delete => "delete".i18n();
  static String get shared => "shared".i18n();
  static String get edit => "edit".i18n();
  static String get hintTitle => "hint-title".i18n();
  static String get note => "note".i18n();
  static String get hintNote => "hint-note".i18n();
  static String get cancel => "cancel".i18n();
  static String get save => "save".i18n();
  static String get saveSuccess => "save-success".i18n();
  static String get editSuccess => "edit-success".i18n();
  static String get saveFailed => "save-failed".i18n();
  static String get editFailed => "edit-failed".i18n();
  static String get fieldRequired => "field-required".i18n();
  static String get notImportance => "not-importance".i18n();
  static String get littleImportance => "little-importance".i18n();
  static String get mediumImportance => "medium-importance".i18n();
  static String get highImportance => "high-importance".i18n();
  static String get veryImportant => "very-importance".i18n();
  static String get colors => "colors".i18n();
  static String get chooseColor => "choose-color".i18n();
  static String get modify => "modify".i18n();
  static String get configs => "configs".i18n();
  static String get darkMode => "dark-mode".i18n();
  static String get languageApp => "language-app".i18n();
  static String get portuguese => "portuguese".i18n();
  static String get spanish => "spanish".i18n();
  static String get english => "english".i18n();
  static String get general => "general".i18n();
  static String get quit => "quit".i18n();
  static String get feedback => 'feedback'.i18n();
  static String get reportBug => 'report-bug'.i18n();
  static String get sendFeedback => 'send-feedback'.i18n();
  static String get infoUser => 'info-user'.i18n();
  static String get name => 'name'.i18n();
  static String get email => 'email'.i18n();
  static String get showMenu => 'show-menu'.i18n();
  static String get logout => 'logout'.i18n();

  //to-do
  static String get errorModifyLocale => 'error-modify-locale'.i18n();
  static String get localeNotExist => 'locale-not-exist'.i18n();
  static String get notRemoveUser => 'not-remove-user'.i18n();
  static String get errorKey => 'error-key'.i18n();
  static String get loginSuccess => 'login-success'.i18n();
  static String get formDataValid => 'form-data-valid'.i18n();
  static String get listShowSuccess => 'list-show-success'.i18n();
  static String get logoutSuccess => 'logout-success'.i18n();
  static String get errorLogout => 'error-logout'.i18n();
  static String get errorLogin => 'error-login'.i18n();
  static String get about => 'about'.i18n();
  static String get desenvBy => 'desenv-by'.i18n();
  static String get localeModifySuccess => 'locale-modify-success'.i18n();

  static String get notLocalizedNote => "not-localized-note".i18n();

  static String textErroSnackbar([List<String> arguments = const []]) =>
      "text-erro-snackbar".i18n(arguments);

  static String erroRoute([List<String> arguments = const []]) =>
      "erro-route".i18n(arguments);

  static String loginErroAdd([List<String> arguments = const []]) =>
      "login-erro-add".i18n(arguments);
}
