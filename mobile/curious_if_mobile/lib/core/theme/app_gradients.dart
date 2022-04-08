import 'dart:math';

import 'package:flutter/material.dart';

abstract class AppGradients {
  Gradient get background;
  Gradient get textGradient;
}

class AppGradientsLight implements AppGradients {
  @override
  Gradient get background => const LinearGradient(
        colors: [Color(0xFF7918C5), Color(0xFF4721B4)],
        stops: [0, 1],
        transform: GradientRotation((225 / 180) * pi),
      );

  @override
  Gradient get textGradient => const LinearGradient(
        colors: [Color(0xFF7918C5), Color(0xFF4721B4)],
        stops: [0, 1],
        begin: Alignment.bottomRight,
        end: Alignment.bottomLeft,
        transform: GradientRotation((0 / 180) * pi),
      );
}

class AppGradientsDark implements AppGradients {
  @override
  Gradient get background => const LinearGradient(
        colors: [Color(0xFF7918C5), Color(0xFF4721B4)],
        stops: [0, 1],
        transform: GradientRotation((225 / 180) * pi),
      );

  @override
  Gradient get textGradient => const LinearGradient(
        colors: [Color(0xFFC275FF), Color(0xFF8963F5)],
        stops: [0, 1],
        begin: Alignment.bottomRight,
        end: Alignment.bottomLeft,
        transform: GradientRotation((-5 / 180) * pi),
      );
}
