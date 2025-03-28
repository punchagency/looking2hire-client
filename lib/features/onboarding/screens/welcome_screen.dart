import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/enums/app_type.dart';
import 'package:looking2hire/features/onboarding/screens/create_employer_account_screen.dart';
import 'package:looking2hire/features/onboarding/screens/linkedin_login_screen.dart';
import 'package:looking2hire/main.dart';
import 'package:looking2hire/service/deep_linking_handler.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 1;
  final PageController pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) => FocusScope.of(context).unfocus(),
        onPanDown: (_) => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: PageView(
            controller: pageController,
            onPageChanged: (index) {
              currentAppType = index == 0 ? AppType.hire : AppType.work;

              // setState(() {
              //   currentPage = index;
              // });
            },
            children: [
              CreateEmployerAccountScreen(pageController: pageController),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 50,
                      left: 36,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          currentAppType = AppType.hire;
                          pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                          // DeepLinkHandler.handleDeepLink(
                          //   context,
                          //   Uri.parse(
                          //     'com.punch.looking2hire://employerProfile',
                          //   ),
                          // );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              AppAssets.backArrow,
                              color: AppColor.arrowColor,
                            ),
                            SizedBox(height: 17),
                            CustomRobotoText(
                              text: "Looking\nTo\nHire",
                              textSize: 50,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      right: 36,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          currentAppType = AppType.work;
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              AppAssets.forwardArrow,
                              color: AppColor.arrowColor,
                            ),
                            SizedBox(height: 17),
                            CustomRobotoText(
                              text: "Looking\nTo\nWork",
                              textSize: 50,
                              fontWeight: FontWeight.w700,
                              alignText: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              LinkedInLoginScreen(pageController: pageController),
            ],
          ),
        ),
      ),
    );
  }
}
