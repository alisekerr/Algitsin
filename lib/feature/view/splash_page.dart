import 'package:algitsin/constants/theme_data.dart';
import 'package:algitsin/feature/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: algitsinThemeData,
      home: AnimatedSplashScreen(
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          splash: Center(
            child: Image.asset(
              "assets/welcome-icon.png",
              fit: BoxFit.contain,
            ),
          ),
          nextScreen: const SellerLogin()),
    );
  }
}
