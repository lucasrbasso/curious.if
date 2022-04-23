abstract class AppImages {
  String get logo;
}

class AppImagesLight implements AppImages {
  @override
  String get logo => 'assets/images/logo_splash_light.png';
}

class AppImagesDark extends AppImagesLight {
  @override
  String get logo => 'assets/images/logo_splash_dark.png';
}
