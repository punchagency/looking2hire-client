import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/provider/nfc_provider.dart';
import 'package:provider/provider.dart';

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
    final titles = [
      "1. Position Your Phone",
      "2. Activate The Decal",
      "3. Activation Successful",
      "4. Best Placement Practices",
    ];
    return Scaffold(
      appBar: CustomAppBar(
        title: titles[currentPage],
        fontSize: 20,
        onBackPressed: () {
          setState(() {
            if (currentPage > 0) {
              currentPage = currentPage - 1;
            } else {
              context.pop();
            }
            context.read<NFCProvider>().isActive = false;
          });
        },
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
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
