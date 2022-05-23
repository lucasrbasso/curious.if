abstract class AppImages {
  String get logo;
  String get logoApp;
  String get checkIcon;
  String cat(int index);
}

class AppImagesLight implements AppImages {
  @override
  String get logo => 'assets/images/logo_splash_light.png';

  @override
  String get logoApp => 'assets/images/logo_app_light.png';

  @override
  String get checkIcon => 'assets/images/check_icon.png';

  @override
  String cat(int index) {
    if (index < 0 || index > 3) index = 0;
    return 'assets/images/cat$index.png';
  }
}

class AppImagesDark extends AppImagesLight {
  @override
  String get logo => 'assets/images/logo_splash_dark.png';

  @override
  String get logoApp => 'assets/images/logo_app_dark.png';
}
