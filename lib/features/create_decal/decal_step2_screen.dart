import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/components/progress_dialog.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/create_decal/decal_step3_screen.dart';
import 'package:looking2hire/provider/nfc_provider.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/next_screen.dart';
import 'package:provider/provider.dart';

class DecalStep2Screen extends StatefulWidget {
  final PageController pageController;
  const DecalStep2Screen({super.key, required this.pageController});

  @override
  State<DecalStep2Screen> createState() => _DecalStep2ScreenState();
}

class _DecalStep2ScreenState extends State<DecalStep2Screen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NFCProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     CustomRobotoText(
                  //       text: "Step 2:",
                  //       textSize: 20,
                  //       fontWeight: FontWeight.w400,
                  //     ),
                  //     CustomRobotoText(
                  //       text: "Activate The Decal",
                  //       textSize: 24,
                  //       fontWeight: FontWeight.w600,
                  //     ),

                  //     Container(width: 40),
                  //   ],
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 132.h),
                      CustomRobotoText(
                        text: "Tap To Activate",
                        textSize: 24,
                        fontWeight: FontWeight.w600,
                      ),

                      SizedBox(height: 12.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: 'Press the ',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            TextSpan(
                              text: '"Activate"',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  // decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  wordSpacing: 0,
                                ),
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      // nextScreen(
                                      //   context,
                                      //   CreateCandidateAccountScreen(),
                                      // );
                                    },
                            ),
                            TextSpan(
                              text:
                                  'button while keeping your phone close to the decal. Hold steady until the activation completes.',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 52.h),
                      Image.asset(AppAssets.smartPhone, height: 202),
                      SizedBox(height: 32.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            TextSpan(
                              text: 'Tip:',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  // decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  wordSpacing: 0,
                                ),
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      // nextScreen(
                                      //   context,
                                      //   CreateCandidateAccountScreen(),
                                      // );
                                    },
                            ),
                            TextSpan(
                              text:
                                  'If activation fails, try repositioning your phone and retrying.',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 40.h),
                      Button(
                        onPressed: () {
                          // nextScreen(context, DecalStep3Screen());
                          // widget.pageController.nextPage(
                          //   duration: const Duration(milliseconds: 300),
                          //   curve: Curves.easeIn,
                          // );
                          // setProgressDialog();
                          provider.activateNfc(
                            operation: NFCOperation.write,
                            url: "looking2hire://employerprofile",
                            pageController: widget.pageController,
                          );
                        },
                        text: "Activate",
                        color: AppColor.black,
                        suffix: true,
                        suffixIcon: SvgPicture.asset(
                          AppAssets.arrowRight,
                          color: AppColor.white,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              TextSpan(
                                text: 'If Activation Fails  ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              TextSpan(
                                text: 'Retry Activation',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  wordSpacing: 0,
                                ),
                                recognizer:
                                    TapGestureRecognizer()
                                      ..onTap = () {
                                        // nextScreen(
                                        //   context,
                                        //   CreateCandidateAccountScreen(),
                                        // );
                                      },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
