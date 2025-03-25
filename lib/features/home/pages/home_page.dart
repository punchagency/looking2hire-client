import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/constants/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/create_job/create_job_post.dart';
import 'package:looking2hire/features/home/models/recomended_jobs.dart';
import 'package:looking2hire/features/home/pages/active_jobs_page.dart';
import 'package:looking2hire/features/home/pages/hire_job_details_page.dart';
import 'package:looking2hire/features/home/pages/job_search_page.dart';
import 'package:looking2hire/features/home/pages/work_job_details_page.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/home/widgets/job_card.dart';
import 'package:looking2hire/features/home/widgets/job_history_item.dart';
import 'package:looking2hire/features/home/widgets/recent_search_item.dart';
import 'package:looking2hire/features/profile/initial_user_profile_page.dart';
import 'package:looking2hire/features/profile/looking_to_hire_profile.dart';
import 'package:looking2hire/features/profile/provider/user_provider.dart';
import 'package:looking2hire/service/navigation_service.dart';
import 'package:looking2hire/service/secure_storage/secure_storage.dart';
import 'package:looking2hire/views/app_drawer.dart';
import 'package:provider/provider.dart';

import '../../../reuseable/widgets/outlined_container.dart';

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
  String? uType;

  Future<void> init() async {
    uType = await SecureStorage().retrieveUserType();
    print(uType);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    selectedSearch = recentSearches.firstOrNull ?? "";
    // context.read<JobProvider>().getRecentJobs();
    currentContext?.read<JobProvider>().getRecommendedJobPosts();
    currentContext?.read<UserProvider>().getApplicantProfile();
    init();
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
        context.pushTo(InitialUserProfilePage());
        // context.pushTo(LookingToHireProfile());
      }
      return;
    }
    context.pushTo(InitialUserProfilePage());
    // context.pushTo(LookingToHireProfile());
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

    return Consumer<JobProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Looking to ${uType == "applicant" ? "Work" : "Hire"}",
            fontSize: 26,
            fontWeight: FontWeight.w500,
            centeredTitle: false,
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
                      OutlinedContainer(
                        child: SvgPicture.asset(AppAssets.filter),
                      ),
                    ],
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 2));
                        currentContext
                            ?.read<JobProvider>()
                            .getRecommendedJobPosts();
                      },
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
                                child: GestureDetector(
                                  onTap: () => context.pushTo(CreateJobPost()),
                                  child: Text(
                                    "Popular jobs",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightBlack,
                                    ),
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
                            "Recommended Jobs",
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
                            itemCount:
                                provider
                                    .recommendedJobs
                                    .recommendedJobs
                                    ?.length ??
                                0,
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 15);
                            },
                            itemBuilder: (context, index) {
                              final data =
                                  provider
                                      .recommendedJobs
                                      .recommendedJobs?[index];
                              return JobHistoryItem(
                                imageUrl: AppAssets.gap,
                                title: data?.jobTitle ?? "",
                                description: data?.summary ?? '',
                                location: data?.jobAddress ?? "",
                                startDate: "Jan 2020",
                                endDate: "Feb 2023",
                                onPressed: () {
                                  provider.recommendedJob =
                                      data ?? RecommendedJob();
                                  context.pushTo(HireJobDetailsPage());
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
