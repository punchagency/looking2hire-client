import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/constants/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/pages/active_jobs_page.dart';
import 'package:looking2hire/features/home/pages/hire_job_details_page.dart';
import 'package:looking2hire/features/home/pages/job_search_page.dart';
import 'package:looking2hire/features/home/pages/work_job_details_page.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/home/widgets/job_card.dart';
import 'package:looking2hire/features/home/widgets/job_history_item.dart';
import 'package:looking2hire/features/home/widgets/recent_search_item.dart';
import 'package:looking2hire/features/profile/initial_user_profile_page.dart';
import 'package:looking2hire/features/profile/looking_to_hire_profile.dart';
import 'package:looking2hire/resusable/widgets/profile_photo.dart';
import 'package:looking2hire/views/app_drawer.dart';

import '../../../resusable/widgets/outlined_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController(viewportFraction: 0.9);
  List<String> recentSearches = [
    "All Jobs",
    "Designer",
    "Doctor",
    "Engineer",
    "Artist",
    "Musician",
  ];
  String selectedSearch = "";
  bool firstTime = true;

  @override
  void initState() {
    super.initState();
    selectedSearch = recentSearches.firstOrNull ?? "";
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void updateSearch(String search) {
    selectedSearch = search;
    setState(() {});
  }

  void viewAllJobs() {}

  void gotoJobSearch() {
    context.pushTo(JobSearchPage());
  }

  void gotoJobDetails() {
    if (isWork) {
      context.pushTo(WorkJobDetailsPage());
      return;
    }
    context.pushTo(HireJobDetailsPage());
  }

  void gotoJobActiveJobs() {
    context.pushTo(ActiveJobsPage());
  }

  void gotoProfile() {
    if (isWork) {
      if (firstTime) {
        context.pushTo(InitialUserProfilePage());
      } else {
        context.pushTo(LookingToHireProfile());
      }
      return;
    }
    context.pushTo(LookingToHireProfile());
  }

  @override
  Widget build(BuildContext context) {
    final jobWidgets = [
      JobCard(
        logoUrl: AppAssets.jobLogo1,
        price: "\$50 - \$75 / Mo",
        title: "Senior Project Manager",
        location: "Tokopedia - Jakarta, ID",
        isFullTime: true,
        isRemote: true,
        isSenior: true,
        bgColor: AppColors.bluishGrey,
        onPressed: gotoJobDetails,
      ),
      JobCard(
        logoUrl: AppAssets.jobLogo2,
        price: "\$50 - \$75 / Mo",
        title: "Junior Graphic Designer",
        location: "OLX - Jakarta, ID",
        isFullTime: true,
        isRemote: true,
        isSenior: false,
        bgColor: Colors.white,
        onPressed: gotoJobDetails,
      ),
    ];

    final jobHistoryWidgets = [
      JobHistoryItem(
        imageUrl: AppAssets.bananaRepublic,
        title: "Target - Marketing Specialist",
        description:
            "Implemented campaigns focusing on community engagement..,",
        location: "California",
        startDate: "Jan 2020",
        endDate: "Feb 2023",
        onPressed: gotoJobActiveJobs,
      ),

      JobHistoryItem(
        imageUrl: AppAssets.gap,
        title: "Google - Product Designer",
        description:
            "Specialized in creating intuitive interfaces for web applications...",
        location: "Pakistan",
        startDate: "Jan 2020",
        endDate: "Feb 2023",
        onPressed: gotoJobActiveJobs,
      ),

      JobHistoryItem(
        imageUrl: AppAssets.apple,
        title: "Apple - UX Designer",
        description:
            "Focused on enhancing user experience for mobile applications...",
        location: "London",
        startDate: "Jan 2020",
        endDate: "Feb 2023",
        onPressed: gotoJobActiveJobs,
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: appTitle,
        fontSize: 26,
        fontWeight: FontWeight.w500,
        canNotGoBack: true,
        needsDrawer: true,
        // rightChild: ProfilePhoto(
        //   imageUrl: AppAssets.profilePicture,
        //   onPressed: gotoProfile,
        // ),
      ),
      endDrawer: AppDrawer(),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: OutlinedContainer(
                      child: Row(
                        children: [
                          SvgPicture.asset(AppAssets.search),
                          const SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: gotoJobSearch,
                              child: Text(
                                "Search jobs within 10 miles",
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(AppAssets.share),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  OutlinedContainer(child: SvgPicture.asset(AppAssets.filter)),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    const SizedBox(height: 11),
                    Text(
                      "Recent searches",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightBlack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    SizedBox(
                      height: 30,
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
                            onPressed: () => updateSearch(search),
                          );
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
                              color: AppColors.lightBlack,
                            ),
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
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    // SizedBox(
                    //   height: 170,
                    //   child: ListView.separated(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: jobWidgets.length,
                    //     separatorBuilder: (context, index) {
                    //       return const SizedBox(width: 15);
                    //     },
                    //     itemBuilder: (context, index) {
                    //       final widget = jobWidgets[index];
                    //       return widget;
                    //     },
                    //   ),
                    // ),
                    SizedBox(
                      height: 180,
                      child: PageView.builder(
                        controller: pageController,
                        scrollDirection: Axis.horizontal,
                        itemCount: jobWidgets.length,

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
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
