import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_colors.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/create_job/get_related_jobs.dart';
import 'package:looking2hire/features/create_job/manually_create_job.dart';
import 'package:looking2hire/features/home/widgets/action_button.dart';
import 'package:looking2hire/features/profile/provider/user_provider.dart';
import 'package:looking2hire/reuseable/widgets/profile_photo.dart';
import 'package:provider/provider.dart';

class InitialUserProfilePage extends StatefulWidget {
  const InitialUserProfilePage({super.key});

  @override
  State<InitialUserProfilePage> createState() => _InitialUserProfilePageState();
}

class _InitialUserProfilePageState extends State<InitialUserProfilePage> {
  void createJobHistory() {
    context.pushTo(ManuallyCreateJob());
  }

  void sendLinkForCVUpload() {
    context.pushTo(GetRelatedJobs());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Looking To Work",
            centeredTitle: true,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            // needsDrawer: true,
          ),
          // endDrawer: AppDrawer(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                ProfilePhoto(
                  size: 200,
                  imageUrl: provider.applicantProfile.user?.profilePic ?? "",
                  isNetwork: true,
                ),
                const SizedBox(height: 19),
                Text(
                  provider.applicantProfile.user?.name ?? "",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: AppColors.blackOnSurface,
                  ),
                ),
                const SizedBox(height: 19),
                Text(
                  provider.applicantProfile.user?.description ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackOnSurface,
                  ),
                ),
                const SizedBox(height: 80),
                ActionButton(
                  height: 50,
                  radius: 15,
                  title: "Manually Create Your Job History",
                  color: AppColors.lighterBlack,
                  onPressed: createJobHistory,
                ),
                const SizedBox(height: 19),
                ActionButton(
                  height: 50,
                  radius: 15,
                  title: "Send Secure Link for CV Upload",
                  color: AppColors.lighterBlack,
                  onPressed: sendLinkForCVUpload,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
