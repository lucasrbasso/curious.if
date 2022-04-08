abstract class SettingsState {}

class SettingsStateEmpty extends SettingsState {}

class SettingsStateLoading extends SettingsState {}

class SettingsStateFailure extends SettingsState {
  final String message;
  SettingsStateFailure({
    required this.message,
  });
}

class SettingsStateSuccess extends SettingsState {
  final String message;
  final Object result;
  SettingsStateSuccess({
    required this.message,
    required this.result,
  });
}
