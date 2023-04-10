import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import '../widgets/auth_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image(
            image: AssetImage('assets/from.png'),
          ),
        ],
      ),
      backgroundColor: Colors.amber,
      nextScreen: const AuthWidget(),
      splashIconSize: 450,
      splashTransition: SplashTransition.slideTransition,
    );
  }
}
