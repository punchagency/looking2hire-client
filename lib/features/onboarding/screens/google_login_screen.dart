import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/onboarding/screens/create_candidate_account_screen.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/next_screen.dart';

class GoogleLoginScreen extends StatelessWidget {
  const GoogleLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Looking To Work!",
        arrowColor: AppColor.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              CustomRobotoText(
                text: "Create Candidate Account",
                textSize: 24,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                text: "Your profile creation takes just seconds with AI",
                textSize: 16,
                fontWeight: FontWeight.w400,
                textColor: AppColor.grey[500],
              ),
              SizedBox(height: 40),

              Button(
                onPressed: () {
                  // nextScreen(context, HomePage());
                },
                text: "Sign in with Google",
                block: true,
                textSize: 14,
                textColor: AppColor.black,
                fontWeight: FontWeight.w700,
                icon: AppAssets.google,
                color: AppColor.white,
                borderColor: AppColor.black.withAlpha(26),
                light: true,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(
                          text: 'Continue With Email',
                          style: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  nextScreen(
                                    context,
                                    CreateCandidateAccountScreen(),
                                  );
                                },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  SvgPicture.asset(
                    AppAssets.forwardArrow,
                    height: 16,
                    color: AppColor.black,
                  ),
                ],
              ),

              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
