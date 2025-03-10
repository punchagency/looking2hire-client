import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/drawer_item.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void gotoDashboard() {}
  void gotoProfile() {}
  void gotoScan() {}
  void gotoAppliedJobs() {}
  void gotoSavedJobs() {}
  void gotoViewedJobs() {}
  void gotoSettings() {}
  void logout() {}

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
