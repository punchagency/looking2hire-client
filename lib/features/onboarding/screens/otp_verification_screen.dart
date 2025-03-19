import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/onboarding/provider/auth_provider.dart';
import 'package:looking2hire/features/onboarding/screens/candidate_sign_in_screen.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:looking2hire/utils/next_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String? accountType;

  const OtpVerificationScreen({super.key, this.accountType});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  int timeLeft = 60;
  bool isCompleted = false;
  String otp = '';
  late CountdownController countdownController;

  String intToTime(int value) {
    int h, m, s;
    h = value ~/ 3600;
    m = ((value - h * 3600)) ~/ 60;
    s = value - (h * 3600) - (m * 60);
    // String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();
    String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();
    String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();
    String result = "$minuteLeft:$secondsLeft";
    return result;
  }



  @override
  void initState() {
    super.initState();
    // On web, disable the browser's context menu since this example uses a custom
    // Flutter-rendered context menu.
    countdownController = CountdownController(autoStart: true);
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();

    /// In case you need an SMS autofill feature
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, color: Color.fromRGBO(30, 60, 87, 1)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.grey[300]!),
      ),
    );

    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(title: "Looking To Work!", arrowColor: AppColor.black),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 32),
                  if (widget.accountType == "employer") ...[
                    CustomRobotoText(
                      text: "Email / Phone Verification",
                      textSize: 24,
                      fontWeight: FontWeight.w600,
                      alignText: TextAlign.start,
                    ),
                    CustomText(
                      text: "Enter OTP sent to your email/phone number",
                      textSize: 16,
                      fontWeight: FontWeight.w400,
                      textColor: AppColor.grey[500],
                    ),
                  ],
                  if (widget.accountType != "employer") ...[
                    CustomRobotoText(
                      text: "OTP Verification",
                      textSize: 24,
                      fontWeight: FontWeight.w600,
                      alignText: TextAlign.start,
                    ),
                    CustomText(
                      text: "Enter OTP sent to your email",
                      textSize: 16,
                      fontWeight: FontWeight.w400,
                      textColor: AppColor.grey[500],
                    ),
                  ],
                  SizedBox(height: 32),
                  Directionality(
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      controller: pinController,
                      focusNode: focusNode,
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      // validator: (value) {
                      //   return  Validator.validateIsNotEmpty(value);
                      // },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                        provider.otp = pin;
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: AppColor.grey[300],
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColor.grey[300]!),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.grey[300]!),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(border: Border.all(color: Colors.redAccent)),
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    children: [
                      RichText(
                        textAlign: TextAlign.start,
                        text: const TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: AppColor.black,
                              height: 1.2),
                          children: <TextSpan>[
                            TextSpan(text: "Code expires in "),
                          ],
                        ),
                      ),
                      Countdown(
                        seconds: timeLeft,
                        build: (BuildContext context, double time) =>
                            CustomOpenSansText(
                              text: "${intToTime(time.toInt())}s",
                              textSize: 14,
                              textColor: AppColor.red,
                              fontWeight: FontWeight.w600,
                            ),
                        interval: const Duration(seconds: 1),
                        controller: countdownController,
                        onFinished: () {
                          setState(() {
                            isCompleted = true;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Don’t receive the OTP?",
                        textSize: 16,
                        fontWeight: FontWeight.w400,
                        textColor: AppColor.grey[500],
                      ),
                      SizedBox(height: 8),
                      InkWell(
                        onTap: () async {
                         if(isCompleted) {

                            await provider.resendOtp(context: context, accountType: widget.accountType == "employer" ? "employer" : "applicant",).then((success) {
                              if (success) {
                                countdownController.restart();
                                setSnackBar(context: context, title: "Success", message: provider.successMessage);
                              } else {
                                setSnackBar(context: context, title: "Error", message: provider.errorMessage);
                              }
                            });
                          }
                        },
                        child: CustomText(
                          text: "Resend OTP",
                          textSize: 18,
                          fontWeight: FontWeight.w600,
                          textColor: isCompleted
                              ? AppColor.black
                              : AppColor.grey[400],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 64),
                  Button(
                    onPressed:  () async {
                      if (provider.otp != "") {
                        await provider
                            .verifyAccount(
                              context: context,
                              accountType: widget.accountType == "employer" ? "employer" : "applicant",
                            )
                            .then((success) {
                              if (success) {
                                setSnackBar(context: context, title: "Success", message: provider.successMessage);
                                // nextScreen(context, isHire ? CandidateSignInScreen() : HomePage());
                                nextScreen(context, CandidateSignInScreen());
                              } else {
                                setSnackBar(context: context, title: "Error", message: provider.errorMessage);
                              }
                            });
                      } else {
                        setSnackBar(context: context, title: "Warning", message: "Please enter OTP");
                      }
                    },
                    text: "Verify",
                    block: true,
                    color: AppColor.buttonColor,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
