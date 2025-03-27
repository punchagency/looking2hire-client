import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/features/home/pages/home_page.dart';
import 'package:looking2hire/features/onboarding/screens/welcome_screen.dart';
import 'package:looking2hire/features/profile/company_profile_page.dart';
import 'package:looking2hire/service/secure_storage/secure_storage.dart';
import 'package:looking2hire/utils/next_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      // nextScreenReplace(context, WelcomeScreen());
      checkLoggedIn();
    });
  }

  Future<void> checkLoggedIn() async {
    final token = await SecureStorage().retrieveToken();
    final userType = await SecureStorage().retrieveUserType();
    await Future.delayed(Duration(microseconds: 500));
    if (token != null && token.isNotEmpty) {
      nextScreenReplace(
        context,
        userType == "employer" ? CompanyProfilePage() : HomePage(),
      );
    } else {
      nextScreenReplace(context, WelcomeScreen());
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: CustomRobotoText(text: "Looking 2 Hire", textSize: 20),
        child: Image.asset("assets/icons/icon.jpg", width: 200, height: 200),
      ),
    );
  }
}
