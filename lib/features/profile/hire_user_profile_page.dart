import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';

class HireUserProfilePage extends StatefulWidget {
  const HireUserProfilePage({super.key});

  @override
  State<HireUserProfilePage> createState() => _HireUserProfilePageState();
}

class _HireUserProfilePageState extends State<HireUserProfilePage> {
  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 10),
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
          Text(
            "Employment History ",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.lightBlack,
            ),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
