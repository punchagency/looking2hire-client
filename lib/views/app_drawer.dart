import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/drawer_item.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/create_decal/decal_step1_screen.dart';
import 'package:looking2hire/features/home/enums/enums.dart';
import 'package:looking2hire/features/home/pages/hire_applied_jobs_page.dart';
import 'package:looking2hire/features/home/pages/jobs_page.dart';
import 'package:looking2hire/features/home/pages/statistics_page.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/profile/looking_to_hire_profile.dart';
import 'package:looking2hire/features/scan/screens/scan_nfc_page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  void gotoDashboard() {
    //context.pushTo(HomePage());
  }

  void gotoProfile() {
    if (isHire) {
      return;
    }
    context.pushTo(LookingToHireProfile());
  }

  void gotoScan() {
    context.pushTo(ScanNfcPage());
  }

  void gotoCreateDecal() {
    context.pushTo(DecalStep1Screen());
  }

  void gotoStatistics() {
    context.pushTo(StatisticsPage());
  }

  void gotoAppliedJobs() {
    if (isHire) {
      context.pushTo(HireAppliedJobsPage());
    } else {
      context.pushTo(JobsPage(jobType: JobType.applied));
    }
  }

  void gotoSavedJobs() {
    context.pushTo(JobsPage(jobType: JobType.saved));
  }

  void gotoViewedJobs() {
    context.pushTo(JobsPage(jobType: JobType.viewed));
  }

  void gotoSettings() {
    //context.pushTo(SettingsPage());
  }

  void logout() {
    // context.pushTo(LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SizedBox(
        //width: 320,
        child: Column(
          children: [
            const SizedBox(height: 35),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: SvgPicture.asset(AppAssets.drawerClose),
              ),
            ),
            const SizedBox(height: 15),

            Expanded(
              child: ListView(
                children: [
                  if (isWork) ...[
                    DrawerItem(
                      icon: AppAssets.dashboard,
                      title: "Dashboard",
                      onPressed: gotoDashboard,
                    ),
                    DrawerItem(
                      icon: AppAssets.profile,
                      title: "Profile",
                      onPressed: gotoProfile,
                    ),
                    DrawerItem(
                      icon: AppAssets.scan,
                      title: "Scan",
                      onPressed: gotoScan,
                    ),
                    DrawerItem(
                      icon: AppAssets.appliedjobs,
                      title: "Applied Jobs",
                      onPressed: gotoAppliedJobs,
                    ),
                    DrawerItem(
                      icon: AppAssets.savedjobs,
                      title: "Saved Jobs",
                      onPressed: gotoSavedJobs,
                    ),
                    DrawerItem(
                      icon: AppAssets.viewedjobs,
                      title: "Viewed Jobs",
                      onPressed: gotoViewedJobs,
                    ),
                  ] else ...[
                    DrawerItem(
                      icon: AppAssets.profile,
                      title: "Profile",
                      onPressed: gotoProfile,
                    ),
                    DrawerItem(
                      icon: AppAssets.createDecal,
                      title: "Create Decal",
                      onPressed: gotoCreateDecal,
                    ),
                    DrawerItem(
                      icon: AppAssets.appliedjobs,
                      title: "Applied Jobs",
                      onPressed: gotoAppliedJobs,
                    ),
                    DrawerItem(
                      icon: AppAssets.statistics,
                      title: "Statistics",
                      onPressed: gotoStatistics,
                    ),
                  ],
                  DrawerItem(
                    icon: AppAssets.settings,
                    title: "Settings",
                    onPressed: gotoSettings,
                  ),
                  DrawerItem(
                    icon: AppAssets.logout,
                    title: "Logout",
                    onPressed: logout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
