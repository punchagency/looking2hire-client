import 'package:flutter/material.dart';

import 'decal_step1_screen.dart';
import 'decal_step2_screen.dart';
import 'decal_step3_screen.dart';
import 'decal_step4_screen.dart';

class DecalScreen extends StatefulWidget {
  const DecalScreen({super.key});

  @override
  State<DecalScreen> createState() => _DecalScreenState();
}

class _DecalScreenState extends State<DecalScreen> {
  int currentPage = 0;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          DecalStep1Screen(pageController: pageController),
          DecalStep2Screen(pageController: pageController),
          DecalStep3Screen(pageController: pageController),
          DecalStep4Screen(),
        ],
      ),
    );
  }
}
