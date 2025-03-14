import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/onboarding/screens/candidate_sign_in_screen.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/next_screen.dart';

import 'otp_verification_screen.dart';

class CreateEmployerAccountScreen extends StatefulWidget {
  const CreateEmployerAccountScreen({super.key});

  @override
  State<CreateEmployerAccountScreen> createState() =>
      _CreateEmployerAccountScreenState();
}

class _CreateEmployerAccountScreenState
    extends State<CreateEmployerAccountScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Looking To Hire",
        arrowColor: AppColor.black,
        centeredTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 64),

              CustomRobotoText(
                text: "Create Employer Account",
                textSize: 24,
                fontWeight: FontWeight.w600,
              ),

              // SizedBox(height: 15),
              CustomText(
                text: "Your profile creation takes just seconds with AI",
                textSize: 16,
                fontWeight: FontWeight.w400,
                textColor: AppColor.grey[500],
              ),
              SizedBox(height: 30),
              CustomIconTextField(
                textEditingController: TextEditingController(),
                textHint: "Business Name",
                icon: AppAssets.business,
              ),

              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: TextEditingController(),
                textHint: "Hiring Contact Full Name",
                icon: AppAssets.user,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: TextEditingController(),
                textHint: "Hiring Contact Email",
                icon: AppAssets.mail,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: TextEditingController(),
                textHint: "Hiring Contact Phone",
                icon: AppAssets.phone,
              ),

              SizedBox(height: 25),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: AppColor.black,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (changed) {
                      isChecked = !isChecked;
                      setState(() {});
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(letterSpacing: 0),
                      children: [
                        TextSpan(text: 'I accepts the Terms ', style: TextStyle(color: Colors.black, fontSize: 14)),
                        TextSpan(
                          text: 'Terms & Conditions',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            letterSpacing: 0,
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
                ],
              ),

              SizedBox(height: 41),
              Button(
                onPressed: () {
                  nextScreen(context, OtpVerificationScreen(
                    accountType: "employer",
                  ));
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
                        text: 'Already have an account?  ',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                nextScreen(context, CandidateSignInScreen());
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
