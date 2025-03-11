import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/onboarding/screens/otp_verification_screen.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/next_screen.dart';

class CreateCandidateAccountScreen extends StatefulWidget {
  const CreateCandidateAccountScreen({super.key});

  @override
  State<CreateCandidateAccountScreen> createState() =>
      _CreateCandidateAccountScreenState();
}

class _CreateCandidateAccountScreenState
    extends State<CreateCandidateAccountScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Get Hired Now!", arrowColor: AppColor.black),
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
              SizedBox(height: 30),
              CustomIconTextField(
                textEditingController: TextEditingController(),
                textHint: "Enter Your Email",
                icon: AppAssets.mail,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: TextEditingController(),
                textHint: "Enter Password",
                icon: AppAssets.lock,
                isPassword: true,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: TextEditingController(),
                textHint: "Confirm Password",
                icon: AppAssets.lock,
                isPassword: true,
              ),
              SizedBox(height: 50),
              Button(
                onPressed: () {
                  nextScreen(context, OtpVerificationScreen());
                },
                text: "Create account",
                block: true,
                color: AppColor.buttonColor,
              ),
              SizedBox(height: 15),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: 'Don’t have an account? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'Signup',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {});
                              },
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
