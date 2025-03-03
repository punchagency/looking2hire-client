import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/features/home/widgets/job_card.dart';
import 'package:looking2hire/features/home/widgets/recent_search_item.dart';
import 'package:looking2hire/resusable/widgets/profile_photo.dart';
import 'package:looking2hire/reuseable/extensions.dart';

import '../../../resusable/widgets/outlined_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> recentSearches = [
    "All Jobs",
    "Designer",
    "Doctor",
    "Engineer",
    "Artist",
    "Musician"
  ];
  String selectedSearch = "";

  void updateSearch(String search) {
    selectedSearch = search;
    setState(() {});
  }

  void viewAllJobs() {}

  @override
  Widget build(BuildContext context) {
    const jobWidgets = [
      JobCard(
          logoUrl: AppAssets.jobLogo1,
          price: "\$50 - \$75 / Mo",
          title: "Senior Project Manager",
          location: "Tokopedia - Jakarta, ID",
          isFullTime: true,
          isRemote: true,
          isSenior: true),
      JobCard(
          logoUrl: AppAssets.jobLogo2,
          price: "\$50 - \$75 / Mo",
          title: "Junior Graphic Designer",
          location: "OLX - Jakarta, ID",
          isFullTime: true,
          isRemote: true,
          isSenior: false),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            CustomAppBar(
              title: "Looking to work",
              rightChild: ProfilePhoto(imageUrl: AppAssets.profilePicture),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedContainer(
                    child: Row(
                      children: [
                        Image.asset(AppAssets.search),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Search jobs within 10 miles",
                            style: TextStyle(
                                color: AppColors.darkGrey,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Image.asset(AppAssets.share),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                OutlinedContainer(child: Image.asset(AppAssets.filter))
              ],
            ),
            const SizedBox(height: 11),
            Text(
              "Recent searches",
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recentSearches.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 5);
                },
                itemBuilder: (context, index) {
                  final search = recentSearches[index];
                  return RecentSearchItem(
                      title: search,
                      selected: selectedSearch == search,
                      onPressed: () => updateSearch(search));
                },
              ),
            ),
            const SizedBox(height: 35),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Popular jobs",
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightBlack),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: viewAllJobs,
                  child: Text(
                    "View all",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightBlack,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: jobWidgets.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 15);
                },
                itemBuilder: (context, index) {
                  final widget = jobWidgets[index];
                  return widget;
                },
              ),
            ),
            const SizedBox(height: 25),
            Text(
              "Job History",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack),
            ),
            const SizedBox(height: 14),
          ],
        ),
      ),
    );
  }
}
