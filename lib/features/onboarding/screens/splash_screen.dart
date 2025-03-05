import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/features/onboarding/screens/welcome_screen.dart';
import 'package:looking2hire/utils/next_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      nextScreenReplace(context, WelcomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomRobotoText(text: "Looking 2 Hire", textSize: 20),
      ),
    );
  }
}
