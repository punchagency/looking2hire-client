import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/provider/nfc_provider.dart';
import 'package:looking2hire/service/navigation_service.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

class DecalStep1Screen extends StatefulWidget {
  final PageController pageController;
  const DecalStep1Screen({super.key, required this.pageController});

  @override
  State<DecalStep1Screen> createState() => _DecalStep1ScreenState();
}

class _DecalStep1ScreenState extends State<DecalStep1Screen> {
  Future<void> nfcSection() async {
    // Check availability
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (isAvailable) {
      print("NFC is available");
    } else {
      print("NFC is not available");
    }

    // Start Session
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        // Do something with an NfcTag instance.
        print(tag.data.values);
      },
    );

    // Stop Session
    //     NfcManager.instance.stopSession();
  }

  @override
  void initState() {
    super.initState();
    // nfcSection();
    currentContext!.read<NFCProvider>().checkNfcAvailability();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

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
                  //       text: "Step 1:",
                  //       textSize: 20,
                  //       fontWeight: FontWeight.w400,
                  //     ),
                  //     CustomRobotoText(
                  //       text: "Position Your Phone",
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
                          // nextScreen(context, DecalStep2Screen());
                          // widget.pageController.nextPage(
                          //   duration: const Duration(milliseconds: 300),
                          //   curve: Curves.easeIn,
                          // );
                          provider.startNFCOperation(
                            operation: NFCOperation.read,
                          );
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
      },
    );
  }
}
