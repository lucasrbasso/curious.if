abstract class AppImages {
  String get logo;
  String get checkIcon;
}

class AppImagesLight implements AppImages {
  @override
  String get logo => 'assets/images/logo_splash_light.png';

  @override
  String get checkIcon => 'assets/images/check_icon.png';
}

class AppImagesDark extends AppImagesLight {
  @override
  String get logo => 'assets/images/logo_splash_dark.png';
}
