import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/constants/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/create_job/create_job_post.dart';
import 'package:looking2hire/features/home/enums/enums.dart';
import 'package:looking2hire/features/home/models/job.dart';
import 'package:looking2hire/features/home/models/recomended_jobs.dart';
import 'package:looking2hire/features/home/pages/active_jobs_page.dart';
import 'package:looking2hire/features/home/pages/hire_job_details_page.dart';
import 'package:looking2hire/features/home/pages/job_search_page.dart';
import 'package:looking2hire/features/home/pages/jobs_page.dart';
import 'package:looking2hire/features/home/pages/locate_job_page.dart';
import 'package:looking2hire/features/home/pages/work_job_details_page.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/home/widgets/job_card.dart';
import 'package:looking2hire/features/home/widgets/job_history_item.dart';
import 'package:looking2hire/features/home/widgets/recent_search_item.dart';
import 'package:looking2hire/features/profile/initial_user_profile_page.dart';
import 'package:looking2hire/features/profile/provider/user_provider.dart';
import 'package:looking2hire/service/navigation_service.dart';
import 'package:looking2hire/service/secure_storage/secure_storage.dart';
import 'package:looking2hire/views/app_drawer.dart';
import 'package:looking2hire/views/loading_or_message_view.dart';
import 'package:provider/provider.dart';

import '../../../reuseable/widgets/outlined_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController(viewportFraction: 0.9);
  // List<String> recentSearches = [
  //   "All Jobs",
  //   "Designer",
  //   "Doctor",
  //   "Engineer",
  //   "Artist",
  //   "Musician",
  // ];

  // List<Color> bgColors = [
  //   Colors.white,
  //   Color(0xFF2196F3), // Vibrant Blue
  //   Color(0xFFE91E63), // Pink
  //   Color(0xFF4CAF50), // Green
  //   Color(0xFFFF9800), // Orange
  //   Color(0xFF9C27B0), // Purple
  //   Color(0xFF00BCD4), // Cyan
  //   Color(0xFF3F51B5), // Indigo
  //   Color(0xFF009688), // Teal
  //   Color(0xFFF44336), // Red
  //   Color(0xFF8BC34A), // Light Green
  //   Color(0xFF795548), // Brown
  //   Color(0xFF607D8B), // Blue Grey
  //   Color(0xFF673AB7), // Deep Purple
  //   Color(0xFF00BCD4), // Cyan
  //   Color(0xFFFF5722), // Deep Orange
  //   Color(0xFFE91E63), // Pink
  //   Color(0xFF009688), // Teal
  //   Color(0xFF2196F3), // Blue
  //   Color(0xFF9C27B0), // Purple
  //   Color(0xFF4CAF50), // Green
  //   Colors.white,
  // ];

  List<Color> bgColors = [
    const Color(0xFFD9D9D9),
    const Color(0xFFFFFFFF),
    const Color(0xFF1e1e1e),
    const Color(0xFF1e1e1e).withOpacity(0.3),
    const Color(0xFF0339A6),
    const Color(0xFF011640),
    const Color(0xFF0468BF),
    const Color(0xFF05AFF2),
    const Color(0xFF05C7F2),
  ];

  List<Color> textColors = [
    Colors.black,
    Colors.black,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  Map<int, Color> popularJobColors = {};

  String selectedSearch = "";
  bool firstTime = true;
  String? uType;

  Future<void> init() async {
    uType = await SecureStorage().retrieveUserType();
    currentContext?.read<JobProvider>().getRecentSearches();
    currentContext?.read<JobProvider>().getRecommendedJobPosts();
    currentContext?.read<JobProvider>().getPopularJobs();
    currentContext?.read<UserProvider>().getApplicantProfile();
    currentContext?.read<JobProvider>().getSavedJobs();
    currentContext?.read<JobProvider>().getViewedJobs();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    //selectedSearch = recentSearches.firstOrNull ?? "";
    // context.read<JobProvider>().getRecentJobs();

    init();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void updateSearch(String search) {
    context.pushTo(JobSearchPage(search: search));
    selectedSearch = search;
    setState(() {});
  }

  void viewPopularJobs() {
    context.pushTo(JobsPage(jobType: JobType.popular));
  }

  void viewRecommendedJobs() {
    context.pushTo(JobsPage(jobType: JobType.recommended));
  }

  void gotoJobSearch() {
    context.pushTo(JobSearchPage());
  }

  void gotoJobDetails(String? jobId) {
    context.pushTo(WorkJobDetailsPage());
    // if (isWork) {
    //   context.pushTo(WorkJobDetailsPage());
    //   return;
    // }
    // context.pushTo(HireJobDetailsPage());
  }

  void gotoJobActiveJobs() {
    context.pushTo(ActiveJobsPage());
  }

  void gotoProfile() {
    // if (isWork) {
    //   if (firstTime) {
    //     context.pushTo(InitialUserProfilePage());
    //   } else {
    //     context.pushTo(InitialUserProfilePage());
    //     // context.pushTo(LookingToHireProfile());
    //   }
    //   return;
    // }
    context.pushTo(InitialUserProfilePage());
    // context.pushTo(LookingToHireProfile());
  }

  void gotoMap() {
    context.pushTo(LocateJobPage());
  }

  @override
  Widget build(BuildContext context) {
    // final jobWidgets = [
    //   JobCard(
    //     logoUrl: AppAssets.jobLogo1,
    //     price: "\$50 - \$75 / Mo",
    //     title: "Senior Project Manager",
    //     location: "Tokopedia - Jakarta, ID",
    //     isFullTime: true,
    //     isRemote: true,
    //     isSenior: true,
    //     bgColor: AppColors.bluishGrey,
    //     onPressed: gotoJobDetails,
    //   ),
    //   JobCard(
    //     logoUrl: AppAssets.jobLogo2,
    //     price: "\$50 - \$75 / Mo",
    //     title: "Junior Graphic Designer",
    //     location: "OLX - Jakarta, ID",
    //     isFullTime: true,
    //     isRemote: true,
    //     isSenior: false,
    //     bgColor: Colors.white,
    //     onPressed: gotoJobDetails,
    //   ),
    // ];

    // final jobHistoryWidgets = [
    //   JobHistoryItem(
    //     imageUrl: AppAssets.bananaRepublic,
    //     title: "Target - Marketing Specialist",
    //     description:
    //         "Implemented campaigns focusing on community engagement..,",
    //     location: "California",
    //     startDate: "Jan 2020",
    //     endDate: "Feb 2023",
    //     onPressed: gotoJobActiveJobs,
    //   ),

    //   JobHistoryItem(
    //     imageUrl: AppAssets.gap,
    //     title: "Google - Product Designer",
    //     description:
    //         "Specialized in creating intuitive interfaces for web applications...",
    //     location: "Pakistan",
    //     startDate: "Jan 2020",
    //     endDate: "Feb 2023",
    //     onPressed: gotoJobActiveJobs,
    //   ),

    //   JobHistoryItem(
    //     imageUrl: AppAssets.apple,
    //     title: "Apple - UX Designer",
    //     description:
    //         "Focused on enhancing user experience for mobile applications...",
    //     location: "London",
    //     startDate: "Jan 2020",
    //     endDate: "Feb 2023",
    //     onPressed: gotoJobActiveJobs,
    //   ),
    // ];

    final provider = context.watch<JobProvider>();

    if (selectedSearch.isEmpty) {
      selectedSearch = provider.recentSearches.firstOrNull?.query ?? "";
    }

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
            // rightChild: RoundedImage(
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
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedContainer(
                          padding: const EdgeInsets.only(left: 10),
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
                              IconButton(
                                onPressed: gotoMap,
                                icon: SvgPicture.asset(AppAssets.share),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(width: 8),
                      // OutlinedContainer(
                      //   child: SvgPicture.asset(AppAssets.filter),
                      // ),
                    ],
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 2));
                        init();
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
                              itemCount: provider.recentSearches.length,
                              separatorBuilder: (context, index) {
                                return const SizedBox(width: 5);
                              },
                              itemBuilder: (context, index) {
                                final recentSearch =
                                    provider.recentSearches[index];
                                return RecentSearchItem(
                                  title: recentSearch.query ?? "",
                                  selected:
                                      selectedSearch == recentSearch.query,
                                  onPressed:
                                      () => updateSearch(
                                        recentSearch.query ?? "",
                                      ),
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
                                onTap: viewPopularJobs,
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
                              itemCount: provider.popularJobs.jobs?.length ?? 0,

                              itemBuilder: (context, index) {
                                final data = provider.popularJobs.jobs?[index];
                                Color? color = popularJobColors[index];
                                int colorIndex = 0;

                                if (color == null) {
                                  colorIndex = Random().nextInt(
                                    bgColors.length,
                                  );
                                  while (index > 0 &&
                                      popularJobColors[index - 1] ==
                                          bgColors[colorIndex]) {
                                    colorIndex = Random().nextInt(
                                      bgColors.length,
                                    );
                                  }

                                  color = bgColors[colorIndex];
                                  popularJobColors[index] = color;
                                } else {
                                  colorIndex = bgColors.indexOf(color);
                                }
                                bool isWhite =
                                    textColors[colorIndex] == Colors.white;

                                return JobCard(
                                  logoUrl: AppAssets.jobLogo1,
                                  price: "\$50 - \$75 / Mo",
                                  title:
                                      data?.jobDetails?.jobTitle ??
                                      "Senior Project Manager",
                                  location:
                                      "${data?.jobDetails?.companyName ?? ""} - ${data?.jobDetails?.jobAddress ?? ""}",
                                  isFullTime: false,
                                  isRemote: true,
                                  isSenior: true,
                                  bgColor: color!,
                                  isWhite: isWhite,
                                  // bgColor:
                                  //     index == 0
                                  //         ? AppColors.bluishGrey
                                  //         : Colors.white,
                                  onPressed:
                                      () =>
                                          gotoJobDetails(data?.jobDetails?.id),
                                );
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
                          LoadingOrMessageView(
                            isLoading: false,
                            showChild:
                                (provider.recommendedJobs.recommendedJobs ?? [])
                                    .isNotEmpty,
                            message:
                                (provider.recommendedJobs.recommendedJobs ?? [])
                                        .isEmpty
                                    ? "No recommended jobs found"
                                    : "",
                            // height: 200,
                            child: ListView.separated(
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
