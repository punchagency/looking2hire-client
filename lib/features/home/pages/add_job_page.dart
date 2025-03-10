import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/home/widgets/action_button.dart';
import 'package:looking2hire/views/app_drawer.dart';

import '../../profile/components/profile_card.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key});

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  void addJobPost() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appTitle,
        centeredTitle: true,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        needsDrawer: true,
      ),
      endDrawer: AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),

        children: [
          const SizedBox(height: 16),

          ProfileCard(
            name: "Crate & Barrel",
            address: "600 Silks Run\nHallandale Beach, FL 33009",
            milesAway: 0.5,
            imageUrl: AppAssets.hireImage,
            showSave: false,
          ),
          const SizedBox(height: 16),

          Text(
            "We have everything we need to inspire our customers. Except you.",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.lightBlack,
            ),
          ),
          const SizedBox(height: 11),
          Text(
            """We inspire purpose-filled living that brings joy to the modern home. With a team of more than 8,000 associates spanning 130 store and distribution locations across the U.S and Canada, we achieve together, drive results and innovate to inspire. Drawn together by a shared passion of our customers and a spirit of fun, we deliver high-quality home furnishings that are expertly designed, responsibly sourced and bring beauty and function to people’s homes. From the day we opened our first store in Chicago in 1962 to the digital innovations that engage millions of customers today, our iconic brand is nearly 60 years in the making and our story is unfolding.
Come make an impact that’s uniquely you.""",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack,
            ),
          ),
          const SizedBox(height: 11),
          Text(
            "Come make an impact that’s uniquely you.",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.lightBlack,
            ),
          ),
          const SizedBox(height: 30),
          ActionButton(
            title: "Add First Job Post",
            color: AppColors.lighterBlack,
            onPressed: addJobPost,
          ),
        ],
      ),
    );
  }
}
