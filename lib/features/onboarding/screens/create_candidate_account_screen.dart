import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/onboarding/provider/auth_provider.dart';
import 'package:looking2hire/features/onboarding/screens/otp_verification_screen.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:looking2hire/utils/next_screen.dart';
import 'package:looking2hire/utils/validators.dart';
import 'package:provider/provider.dart';

class CreateCandidateAccountScreen extends StatefulWidget {
  const CreateCandidateAccountScreen({super.key});

  @override
  State<CreateCandidateAccountScreen> createState() =>
      _CreateCandidateAccountScreenState();
}

class _CreateCandidateAccountScreenState
    extends State<CreateCandidateAccountScreen> {
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  bool passwordsMatch = true;

  void validatePasswords(
    TextEditingController password,
    TextEditingController cPassword,
  ) {
    setState(() {
      passwordsMatch = password.text == cPassword.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          // onHorizontalDragStart: (_) => FocusScope.of(context).unfocus(),
          // onVerticalDragStart: (_) => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: CustomAppBar(
              title: "Looking To Work!",
              arrowColor: AppColor.black,
            ),
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
                        text: "Create Candidate Account",
                        textSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(
                        text:
                            "Your profile creation takes just seconds with AI",
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
                        onChanged:
                            (value) => validatePasswords(
                              provider.passwordController,
                              provider.confirmPasswordController,
                            ),
                        validate: (value) {
                          return Validator.validateIsNotEmpty(value);
                        },
                      ),
                      SizedBox(height: 16),
                      CustomIconTextField(
                        textEditingController:
                            provider.confirmPasswordController,
                        textHint: "Confirm Password",
                        icon: AppAssets.lock,
                        isPassword: true,
                        onChanged:
                            (value) => validatePasswords(
                              provider.passwordController,
                              provider.confirmPasswordController,
                            ),
                        validate: (value) {
                          return Validator.validateIsNotEmpty(value);
                        },
                      ),
                      SizedBox(height: 50),
                      Button(
                        onPressed: () async {
                          if (formKey.currentState?.validate() == true) {
                            validatePasswords(
                              provider.passwordController,
                              provider.confirmPasswordController,
                            );
                            if (!passwordsMatch) {
                              setSnackBar(
                                context: context,
                                title: "Error",
                                message: "Passwords do not match",
                              );
                              return;
                            } else {
                              await provider
                                  .createApplicantAccount(context: context)
                                  .then((success) {
                                    if (success) {
                                      setSnackBar(
                                        context: context,
                                        title: "Success",
                                        message: provider.successMessage,
                                      );
                                      nextScreen(
                                        context,
                                        OtpVerificationScreen(),
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
                          }
                        },
                        text: "Create account",
                        block: true,
                        color: AppColor.buttonColor,
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
