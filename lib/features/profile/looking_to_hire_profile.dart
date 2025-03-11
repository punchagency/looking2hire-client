import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/profile/components/profile_job_history_card.dart';
import 'package:looking2hire/resusable/widgets/profile_photo.dart';
import 'package:looking2hire/views/app_drawer.dart';

import '../home/widgets/job_information_item.dart';

class LookingToHireProfile extends StatefulWidget {
  const LookingToHireProfile({super.key});

  @override
  State<LookingToHireProfile> createState() => _LookingToHireProfileState();
}

class _LookingToHireProfileState extends State<LookingToHireProfile> {
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

  void gotoEditProfile() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appTitle,
        arrowColor: AppColor.arrowColor,
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
            // ProfileCard(
            //   name: "Michael Smith",
            //   address: "Hallandale Beach, FL 33009",
            //   milesAway: 0.5,
            // ),
            Row(
              children: [
                ProfilePhoto(imageUrl: AppAssets.profilePicture2, size: 80),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    "Michael Smith",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlack,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: gotoEditProfile,
                  icon: SvgPicture.asset(AppAssets.edit),
                ),
              ],
            ),
            SizedBox(height: 14),
            JobInformationItem(
              title: "Reliable and hardworking, expert in retail sales.",
              fontSize: 22,
              value:
                  "I am a reliable and hardworking professional with expertise in retail sales. I excel at providing excellent customer service, driving sales and building lasting customer relationships. With a strong work ethic and a focus in results, I am committed to contributing to the success of any team I join.",
            ),
            SizedBox(height: 35),
            Text(
              "Job History",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.lightBlack,
              ),
            ),
            const SizedBox(height: 14),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: jobHistoryWidgets.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 15);
              },
              itemBuilder: (context, index) {
                final widget = jobHistoryWidgets[index];
                return widget;
              },
            ),
          ],
        ),
      ),
    );
  }
}
