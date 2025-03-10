import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/home/widgets/action_button.dart';
import 'package:looking2hire/features/home/widgets/job_information_item.dart';
import 'package:looking2hire/views/app_drawer.dart';

import '../../profile/components/profile_card.dart';

class JobDisplayPage extends StatefulWidget {
  const JobDisplayPage({super.key});

  @override
  State<JobDisplayPage> createState() => _JobDisplayPageState();
}

class _JobDisplayPageState extends State<JobDisplayPage> {
  void applyForJob() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: appTitle,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        centeredTitle: true,
        needsDrawer: true,
      ),
      endDrawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),

        child: Stack(
          children: [
            ListView(
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

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Sales Associate",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightBlack,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppAssets.save3),
                    ),
                  ],
                ),
                const SizedBox(height: 11),
                Text(
                  """Crate & Barrel is seeking a friendly and motivates Sales Associate to join our team. In this role, you will provide exceptional customer service, help customers find the perfect furniture and home decor and create a welcoming shopping experience.""",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightBlack,
                  ),
                ),
                const SizedBox(height: 11),
                JobInformationItem(
                  title: "Key Responsibilities:",
                  options: [
                    "Assist customers with product inquires, selections and purchases.",
                    "Maintain product knowledge of furniture, home decor and seasonal collections.",
                    "Collaborate with team members to meet store sales goals.",
                    "Ensure display and merchandise are well-organized and visually appealing.",
                    "Process transactions, returns and exchanges efficiently.",
                  ],
                ),
                const SizedBox(height: 11),
                JobInformationItem(
                  title: "Qualifications:",
                  options: [
                    "Strong communication and customer service skills.",
                    "Ability to work in a fast-paces, team-oriented environment.",
                    "Prior retail or sales experience (preferred).",
                    "Passion for interior design and home furnishings.",
                  ],
                ),
                const SizedBox(height: 11),
                Text(
                  """Join us at Crate & Barrel and inspire customers to deign beautiful, functional spaces!""",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightBlack,
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: ActionButton(
                title: "Apply Now",
                color: AppColors.lighterBlack,
                onPressed: applyForJob,
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 20),
      //   child: ActionButton(
      //     title: "Apply Now",
      //     color: AppColors.lighterBlack,
      //     onPressed: applyForJob,
      //   ),
      // ),
    );
  }
}
