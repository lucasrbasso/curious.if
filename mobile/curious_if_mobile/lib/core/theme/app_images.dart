abstract class AppImages {
  String get backgroundLogin;
  String get iconGoogle;
  String get iconApple;
  String get logo;
  String get note;
}

class AppImagesLight implements AppImages {
  @override
  String get backgroundLogin => "assets/images/backgroundLight.png";

  @override
  String get iconGoogle => "assets/images/google-icon.png";

  @override
  String get iconApple => "assets/images/apple-icon-light.png";

  @override
  String get logo => "assets/images/logo.png";

  @override
  String get note => "assets/images/note_light.png";
}

class AppImagesDark extends AppImagesLight {
  @override
  String get backgroundLogin => "assets/images/backgroundDark.png";

  @override
  String get iconApple => "assets/images/apple-icon-dark.png";

  @override
  String get note => "assets/images/note_dark.png";
}
