import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/create_decal/decal_step4_screen.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/next_screen.dart';

class DecalStep3Screen extends StatefulWidget {
  final PageController pageController;
  const DecalStep3Screen({super.key, required this.pageController});

  @override
  State<DecalStep3Screen> createState() => _DecalStep3ScreenState();
}

class _DecalStep3ScreenState extends State<DecalStep3Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomRobotoText(
                    text: "Step 3:",
                    textSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  Flexible(
                    child: CustomRobotoText(
                      text: "Activation Successful",
                      textSize: 24,
                      fontWeight: FontWeight.w600,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Container(width: 40),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 132.h),
                  CustomRobotoText(
                    text: "Decal Activated",
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
                          text: 'Your ',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        TextSpan(
                          text: 'Looking to Hire',
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
                              'sticker is now active! Candidates can tap their phones on the sticker to view job openings.',
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

                  SizedBox(height: 32.h),
                  Image.asset(AppAssets.activated, height: 110),
                  SizedBox(height: 32.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomRobotoText(
                        text: "What’s Next?",
                        textSize: 16,
                        alignText: TextAlign.start,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 8.h),
                      CustomRobotoText(
                        text:
                            "• Candidates can scan the decal to see job listings.",
                        textSize: 16,
                        alignText: TextAlign.start,
                        fontWeight: FontWeight.w400,
                      ),
                      CustomRobotoText(
                        text:
                            "• You can track engagement through your dashboard",
                        textSize: 16,
                        alignText: TextAlign.start,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),

                  SizedBox(height: 40.h),
                  Button(
                    onPressed: () {
                      // nextScreen(context, DecalStep4Screen());
                      widget.pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    text: "Continue",
                    color: AppColor.black,
                    suffix: true,
                    suffixIcon: SvgPicture.asset(
                      AppAssets.arrowRight,
                      color: AppColor.white,
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
