import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/create_decal/decal_step2_screen.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/next_screen.dart';

class DecalStep1Screen extends StatelessWidget {
  const DecalStep1Screen({super.key});

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
                    text: "Step 1:",
                    textSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomRobotoText(
                    text: "Position Your Phone",
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
                    text: "Hold Your Phone Close",
                    textSize: 24,
                    fontWeight: FontWeight.w600,
                  ),

                  SizedBox(height: 12.h),
                  CustomRobotoText(
                    text:
                        "Align the top of your phone with the Looking to Hire sticker to ensure a proper NFC scan. Make sure your phone is steady and close to the decal.",
                    textSize: 16,
                    fontWeight: FontWeight.w400,
                    alignText: TextAlign.center,
                  ),
                  SizedBox(height: 52.h),
                  Image.asset(AppAssets.nfcScan),
                  SizedBox(height: 67.h),
                  Button(
                    onPressed: () {
                      nextScreen(context, DecalStep2Screen());
                    },
                    text: "Next Step",
                    color: AppColor.black,
                    suffix: true,
                    suffixIcon: SvgPicture.asset(
                      AppAssets.arrowRight,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
