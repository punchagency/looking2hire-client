import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/home/pages/home_page.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/onboarding/provider/auth_provider.dart';
import 'package:looking2hire/features/onboarding/screens/create_candidate_account_screen.dart';
import 'package:looking2hire/features/profile/company_profile_page.dart';
import 'package:looking2hire/features/profile/looking_to_hire_profile.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:looking2hire/utils/next_screen.dart';
import 'package:looking2hire/utils/validators.dart';
import 'package:provider/provider.dart';

class CandidateSignInScreen extends StatefulWidget {
  const CandidateSignInScreen({super.key});

  @override
  State<CandidateSignInScreen> createState() => _CandidateSignInScreenState();
}

class _CandidateSignInScreenState extends State<CandidateSignInScreen> {
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(title: appTitle, arrowColor: AppColor.black),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32),
                    CustomRobotoText(
                      text: "Welcome Back",
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
                      textEditingController: provider.emailController,
                      textHint: "Enter Your Email",
                      icon: AppAssets.mail,
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

                    SizedBox(height: 50),
                    Button(
                      onPressed: () async {
                        if (formKey.currentState?.validate() == true) {
                          isHire
                              ? await provider
                                  .loginEmployer(context: context)
                                  .then((success) {
                                    if (success) {
                                      setSnackBar(
                                        context: context,
                                        title: "Success",
                                        message: provider.successMessage,
                                      );
                                      nextScreenReplace(
                                        context,
                                        CompanyProfilePage(),
                                      );
                                    } else {
                                      setSnackBar(
                                        context: context,
                                        title: "Error",
                                        message: provider.errorMessage,
                                      );
                                    }
                                  })
                              : await provider
                                  .loginApplicant(context: context)
                                  .then((success) {
                                    if (success) {
                                      setSnackBar(
                                        context: context,
                                        title: "Success",
                                        message: provider.successMessage,
                                      );
                                      nextScreenReplace(context, HomePage());
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
                      text: "Login",
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
                              text: "Don't have an account? ",
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
                                      nextScreen(
                                        context,
                                        CreateCandidateAccountScreen(),
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
