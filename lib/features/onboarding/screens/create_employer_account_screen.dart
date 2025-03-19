import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/onboarding/provider/auth_provider.dart';
import 'package:looking2hire/features/onboarding/screens/candidate_sign_in_screen.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:looking2hire/utils/next_screen.dart';
import 'package:looking2hire/utils/validators.dart';
import 'package:provider/provider.dart';

import 'otp_verification_screen.dart';

class CreateEmployerAccountScreen extends StatefulWidget {
  final PageController pageController;

  const CreateEmployerAccountScreen({super.key, required this.pageController});

  @override
  State<CreateEmployerAccountScreen> createState() =>
      _CreateEmployerAccountScreenState();
}

class _CreateEmployerAccountScreenState
    extends State<CreateEmployerAccountScreen> {
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Looking To Hire",
            arrowColor: AppColor.black,
            canNotGoBack: true,

            rightChild: IconButton(
              icon: SvgPicture.asset(
                AppAssets.forwardArrow,
                color: AppColor.arrowColor,
              ),
              onPressed: () {
                widget.pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              top: true,
              child: Form(
                key: formKey,
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
                      textEditingController: provider.companyNameController,
                      textHint: "Business Name",
                      icon: AppAssets.business,
                      validate: (value) {
                        return Validator.validateIsNotEmpty(value);
                      },
                    ),

                    SizedBox(height: 16),
                    CustomIconTextField(
                      textEditingController: provider.fullNameController,
                      textHint: "Hiring Contact Full Name",
                      icon: AppAssets.user,
                      validate: (value) {
                        return Validator.validateIsNotEmpty(value);
                      },
                    ),
                    SizedBox(height: 16),
                    CustomIconTextField(
                      textEditingController: provider.emailController,
                      textHint: "Hiring Contact Email",
                      icon: AppAssets.mail,
                      validate: (value) {
                        return Validator.validateIsNotEmpty(value);
                      },
                    ),
                    SizedBox(height: 16),
                    CustomIconTextField(
                      textEditingController: provider.phoneController,
                      textHint: "Hiring Contact Phone",
                      icon: AppAssets.phone,
                      validate: (value) {
                        return Validator.validateIsNotEmpty(value);
                      },
                    ),
                    SizedBox(height: 16),
                    CustomIconTextField(
                      textEditingController: provider.passwordController,
                      textHint: "Enter Password",
                      icon: AppAssets.lock,
                      isPassword: true,
                      validate: (value) {
                        return Validator.validateIsNotEmpty(value);
                      },
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: AppColor.black,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                              TextSpan(
                                text: 'I accepts the Terms ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
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
                                    TapGestureRecognizer()..onTap = () {},

                                // setState(() {});
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 41),
                    Button(
                      onPressed: () async {
                        if (formKey.currentState?.validate() == true) {
                          await provider
                              .createEmployersAccount(context: context)
                              .then((success) {
                                if (success) {
                                  setSnackBar(
                                    context: context,
                                    title: "Success",
                                    message: provider.successMessage,
                                  );
                                  nextScreen(
                                    context,
                                    OtpVerificationScreen(
                                      accountType: "employer",
                                    ),
                                  );
                                } else {
                                  setSnackBar(
                                    context: context,
                                    title: "Error",
                                    message: provider.errorMessage,
                                  );
                                }
                              });
                        }
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
                                      nextScreen(
                                        context,
                                        CandidateSignInScreen(),
                                      );
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
          ),
        );
      },
    );
  }
}
