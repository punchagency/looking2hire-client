import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/features/home/widgets/employment_history_item.dart';

class HireUserProfilePage extends StatefulWidget {
  const HireUserProfilePage({super.key});

  @override
  State<HireUserProfilePage> createState() => _HireUserProfilePageState();
}

class _HireUserProfilePageState extends State<HireUserProfilePage> {
  @override
  Widget build(BuildContext context) {
    final employmentHistoryWidgets = [
      EmploymentHistoryItem(
        companyName: "ABC Tech Solutions",
        jobTitle: "Senior UI/UX Designer",
        startDate: "Jan 2022",
        endDate: "Present",
        responsibilities: [
          "Led the redesign of the company's flagship SaaS platform, improving user engagement by 35%.",
          "Conducted user research and usability testing to refine design solutions.",
          "Worked closely with developers to ensure smooth design-to-development handoff.",
        ],
      ),

      EmploymentHistoryItem(
        companyName: "Creative Minds Agency",
        jobTitle: "UI/UX Designer",
        startDate: "July 2019",
        endDate: "Dec 2021",
        responsibilities: [
          "Designed and developed over 20 mobile and web applications for clients across multiple industries.",
          "Created design systems and component libraries for scalable design solutions.",
          "Collaborated with marketing teams to enhance digital branding efforts.",
        ],
      ),
    ];
    return Scaffold(
      appBar: CustomAppBar(title: "User Profile"),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(AppAssets.profilePicture3),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Emily Carter",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightBlack,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Senior UI/UX Designer",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightBlack,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "About Emily",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlack,
            ),
          ),
          const SizedBox(height: 4),

          Text(
            "Creative and detail-oriented UI/UX Designer with 5+ years of experience crafting intuitive and engaging digital experiences. Passionate about user-centered design, wireframing, and prototyping to create seamless web and mobile applications. Adept at collaborating with cross-functional teams to deliver innovative solutions.",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlack,
            ),
          ),
          const SizedBox(height: 20),

          Text(
            "Employment History ",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlack,
            ),
          ),
          const SizedBox(height: 10),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: employmentHistoryWidgets.length,
            // separatorBuilder: (context, index) {
            //   return const SizedBox(height: 14);
            // },
            itemBuilder: (context, index) {
              final widget = employmentHistoryWidgets[index];
              return widget;
            },
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
