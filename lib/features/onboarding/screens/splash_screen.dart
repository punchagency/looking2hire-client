import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:looking2hire/enums/app_type.dart';
import 'package:looking2hire/features/create_decal/model/write_nfc.dart';
import 'package:looking2hire/features/home/pages/home_page.dart';
import 'package:looking2hire/features/onboarding/screens/welcome_screen.dart';
import 'package:looking2hire/features/profile/company_profile_page.dart';
import 'package:looking2hire/main.dart';
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
      handleDeepLink();
    });
  }

  Future<NfcTagData?> handleNfcIntent() async {
    try {
      final jsonString = await platform.invokeMethod<String>(
        'getInitialIntent',
      );
      print('Received NFC data: $jsonString'); // Debug print
      if (jsonString != null && jsonString.isNotEmpty) {
        return NfcTagData.fromJson(jsonString);
      }
    } on PlatformException catch (e) {
      print('NFC Intent Error: ${e.message}'); // Debug print
    }
    return null;
  }

  Future<void> handleDeepLink() async {
    handleNfcIntent().then((tagData) {
      if (tagData != null) {
        Navigator.pushNamed(
          context,
          tagData.route,
          arguments: {
            'id': tagData.id,
            'name': tagData.name,
            'extra': tagData.extraData,
          },
        );
      } else {
        checkLoggedIn();
      }
    });
  }

  Future<void> checkLoggedIn() async {
    final token = await SecureStorage().retrieveToken();
    final userType = await SecureStorage().retrieveUserType();
    await Future.delayed(Duration(microseconds: 500));
    if (token != null && token.isNotEmpty) {
      currentAppType = userType == "employer" ? AppType.hire : AppType.work;
      nextScreenReplace(
        context,
        userType == "employer" ? CompanyProfilePage() : HomePage(),
      );
    } else {
      currentAppType = AppType.hire;
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
