import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/home/pages/home_page.dart';
import 'package:looking2hire/features/profile/company_profile_page.dart';

import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/next_screen.dart';

class DecalStep4Screen extends StatefulWidget {
  const DecalStep4Screen({super.key});

  @override
  State<DecalStep4Screen> createState() => _DecalStep4ScreenState();
}

class _DecalStep4ScreenState extends State<DecalStep4Screen> {
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
                    text: "Step 4:",
                    textSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomRobotoText(
                    text: "Best Placement Practices",
                    textSize: 24,
                    fontWeight: FontWeight.w600,
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
                    text: "Where to Place Your Sticker",
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
                          text: 'For ',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        TextSpan(
                          text: 'maximum visibility ',
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
                          text: 'place the Looking to Hire sticker on:',
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
                  CustomRobotoText(
                    text: "• Retail front windows at eye level.",
                    textSize: 16,
                    alignText: TextAlign.start,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomRobotoText(
                    text: "• Doors or high-traffic entry points.",
                    textSize: 16,
                    alignText: TextAlign.start,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomRobotoText(
                    text: "• Areas with good lighting for easy scanning.",
                    textSize: 16,
                    alignText: TextAlign.start,
                    fontWeight: FontWeight.w400,
                  ),

                  SizedBox(height: 32.h),
                  Image.asset(AppAssets.placement, height: 202),
                  SizedBox(height: 32.h),

                  Button(
                    onPressed: () {
                      // nextScreen(context, HomePage());
                      nextScreen(context, CompanyProfilePage());
                    },
                    text: "Done",
                    color: AppColor.black,

                    icon: AppAssets.done,
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
