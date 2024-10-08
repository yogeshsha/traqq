import 'package:flutter/material.dart';
import 'package:splashify/splashify.dart';
import 'package:traqq/constants/image_constants.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Splashify(
        imageFadeIn: true,
        blurIntroAnimation: true,
        backgroundColor: Theme.of(context).primaryColor,
        imagePath: ImageConstants.logo,
        child: const HomeScreen());
  }
}
