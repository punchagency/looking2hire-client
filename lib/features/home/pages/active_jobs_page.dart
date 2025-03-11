import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/pages/add_job_page.dart';
import 'package:looking2hire/features/home/pages/job_display_page.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/home/widgets/action_button.dart';
import 'package:looking2hire/features/home/widgets/active_job_item.dart';
import 'package:looking2hire/views/app_drawer.dart';

import '../../profile/components/profile_card.dart';

class ActiveJobsPage extends StatefulWidget {
  const ActiveJobsPage({super.key});

  @override
  State<ActiveJobsPage> createState() => _ActiveJobsPageState();
}

class _ActiveJobsPageState extends State<ActiveJobsPage> {
  void addJob() {
    context.pushTo(AddJobPage());
  }

  void viewJob() {
    context.pushTo(JobDisplayPage());
  }

  @override
  Widget build(BuildContext context) {
    final activeJobWidgets = [
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
    return Scaffold(
      appBar: CustomAppBar(
        title: appTitle,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        centeredTitle: true,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Our Active Jobs",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightBlack,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ActionButton(
                    height: 34,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    title: "Add Job",
                    color: AppColors.lighterBlack,
                    onPressed: addJob,
                  ),
                ],
              ),
              const SizedBox(height: 20),

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
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}
