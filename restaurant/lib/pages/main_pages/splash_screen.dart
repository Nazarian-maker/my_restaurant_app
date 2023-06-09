import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'auth_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SingleChildScrollView(
        child: Column(
          children: const [
            Image(
              image: AssetImage('assets/from.png'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.yellow,
      nextScreen: const AuthWidget(),
      splashIconSize: 550,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
