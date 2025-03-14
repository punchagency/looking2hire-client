import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/action_button_with_icon.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/pages/hire_job_post_details_page.dart';
import 'package:looking2hire/features/home/pages/job_card_page.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/home/widgets/active_job_item.dart';
import 'package:looking2hire/features/profile/components/profile_card.dart';
import 'package:looking2hire/features/profile/components/profile_job_history_card.dart';
import 'package:looking2hire/reuseable/widgets/profile_photo.dart';
import 'package:looking2hire/views/app_drawer.dart';

import '../home/widgets/job_information_item.dart';

class CompanyProfilePage extends StatefulWidget {
  const CompanyProfilePage({super.key});

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  late final activeJobWidgets = [
    ActiveJobItem(
      title: "Sales Associate",
      desc: "Description duis aute irure dolor in reprehenderit.....",
      date: "Today",
      time: "23 min",
      onPressed: viewJob,
    ),
    ActiveJobItem(
      title: "Designer Consultant",
      desc: "Description duis aute irure dolor in reprehenderit.....",
      date: "Today",
      time: "23 min",
      onPressed: viewJob,
    ),
  ];
  final jobHistoryWidgets = [
    ProfileJobHistoryCard(
      companyLogo: AppAssets.apple,
      jobTitle: "West Elm - Retail Sales",
      jobDescription: "Description duis aute irure dolor.....",
      startDate: "Feb 2023",
      endDate: "Jan 2023",
    ),

    ProfileJobHistoryCard(
      companyLogo: AppAssets.gap,
      jobTitle: "West Elm - Retail Sales",
      jobDescription: "Description duis aute irure dolor.....",
      startDate: "Feb 2023",
      endDate: "Jan 2023",
      isSaved: true,
    ),

    ProfileJobHistoryCard(
      companyLogo: AppAssets.bananaRepublic,
      jobTitle: "West Elm - Retail Sales",
      jobDescription: "Description duis aute irure dolor.....",
      startDate: "Feb 2023",
      endDate: "Jan 2023",
    ),
  ];
  void gotoAddJobPost() {
    context.pushTo(const HireJobPostDetailsPage());
  }

  void gotoCreateJob() {}

  void viewJob() {
    context.pushTo(JobCardPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appTitle,
        // arrowColor: AppColor.arrowColor,
        centeredTitle: true,
        fontWeight: FontWeight.w600,
        needsDrawer: true,
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(
              name: "Michael Smith",
              address: "Hallandale Beach, FL 33009",
              milesAway: 0.5,
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

            SizedBox(height: 35),
            ActionButtonWithIcon(
              title: "Add First Job Post",
              icon: AppAssets.addRounded,
              onPressed: gotoAddJobPost,
            ),

            const SizedBox(height: 30),

            Text(
              "Job Cards",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.lightBlack,
              ),
            ),
            const SizedBox(height: 14),

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activeJobWidgets.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 26);
              },
              itemBuilder: (context, index) {
                final widget = activeJobWidgets[index];
                return widget;
              },
            ),

            // ListView.separated(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemCount: jobHistoryWidgets.length,
            //   separatorBuilder: (context, index) {
            //     return const SizedBox(height: 15);
            //   },
            //   itemBuilder: (context, index) {
            //     final widget = jobHistoryWidgets[index];
            //     return widget;
            //   },
            // ),
            SizedBox(height: 35),
            ActionButtonWithIcon(
              title: "Create job",
              icon: AppAssets.bag,
              onPressed: gotoCreateJob,
            ),
          ],
        ),
      ),
    );
  }
}
