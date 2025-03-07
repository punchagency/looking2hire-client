import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/create_job/get_related_jobs.dart';
import 'package:looking2hire/features/create_job/manually_create_job.dart';
import 'package:looking2hire/features/create_job/upload_cv_screen.dart';
import 'package:looking2hire/features/onboarding/screens/create_candidate_account_screen.dart';
import 'package:looking2hire/features/onboarding/screens/create_employer_account_screen.dart';
import 'package:looking2hire/features/onboarding/screens/login_screen.dart';
import 'package:looking2hire/utils/next_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 50,
                left: 36,
                child: GestureDetector(
                  onTap: () {
                    nextScreen(context, CreateEmployerAccountScreen());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AppAssets.backArrow,
                        color: AppColor.arrowColor,
                      ),
                      SizedBox(height: 17),
                      CustomRobotoText(
                        text: "Looking\nTo\nHire",
                        textSize: 50,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                right: 36,
                child: GestureDetector(
                  onTap: () {
                    nextScreen(context, UploadCvScreen());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset(
                        AppAssets.forwardArrow,
                        color: AppColor.arrowColor,
                      ),
                      SizedBox(height: 17),
                      CustomRobotoText(
                        text: "Looking\nTo\nWork",
                        textSize: 50,
                        fontWeight: FontWeight.w700,
                        alignText: TextAlign.end,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
