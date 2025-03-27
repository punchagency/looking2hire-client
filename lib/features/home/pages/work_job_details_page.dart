import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:looking2hire/components/bottom_sheet_container.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_popup.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_colors.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/pages/job_display_page.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/widgets/action_button.dart';
import 'package:looking2hire/features/home/widgets/job_details_tabbar.dart';
import 'package:looking2hire/features/home/widgets/job_information_item.dart';
import 'package:looking2hire/utils/location.dart';
import 'package:looking2hire/views/message_view.dart';
import 'package:provider/provider.dart';

class WorkJobDetailsPage extends StatefulWidget {
  const WorkJobDetailsPage({super.key});

  @override
  State<WorkJobDetailsPage> createState() => _WorkJobDetailsPageState();
}

class _WorkJobDetailsPageState extends State<WorkJobDetailsPage> {
  List<String> menuOptions = ["Save", "Share"];
  List<String> menuLogos = [AppAssets.save2, AppAssets.share2];
  double miles = 0;

  int selectedTab = 0;
  void toggleTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  void toggleSelectOptions(String option) {
    final jobProvider = context.read<JobProvider>();
    final job = jobProvider.job;
    if (job == null) return;
    if (option == "Save") {
      jobProvider.saveJob(jobId: job.id);
    } else if (option == "Share") {}
  }

  void apply() {}

  void viewJob() {
    context.pushTo(JobDisplayPage());
  }

  @override
  void initState() {
    super.initState();
    getJobPost();
    getMiles();
  }

  void getJobPost() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final jobProvider = context.read<JobProvider>();
    final job = jobProvider.job;
    if (job == null) return;
    jobProvider.getJobPost(jobId: job.id);
  }

  void getMiles() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final jobProvider = context.read<JobProvider>();
    final job = jobProvider.job;
    Position? currentPosition = jobProvider.currentPosition;
    currentPosition ??= await getCurrentLocation();
    if (currentPosition == null || job == null || job.employer == null) return;
    miles = getMilesBetweenTwoPoints(
      currentPosition.latitude,
      currentPosition.longitude,
      job.employer!.location![0],
      job.employer!.location![1],
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    const tabs = ["Job Details", "Company"];
    final jobProvider = context.watch<JobProvider>();
    final job = jobProvider.job;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Looking To Work",
        centeredTitle: true,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        // needsDrawer: true,
      ),
      // endDrawer: AppDrawer(),
      body:
          job == null
              ? MessageView(message: "No job found")
              : Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 15,
                    right: 15,
                    child: Container(
                      height: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image:
                              (job.employer?.company_logo ?? "").isNotEmpty
                                  ? CachedNetworkImageProvider(
                                    job.employer!.company_logo!,
                                  )
                                  : AssetImage(AppAssets.defaultProfilePic)
                                      as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerScrolled) {
                        return [
                          SliverAppBar(
                            leading: Container(),
                            actions: [],
                            expandedHeight: 300,
                            collapsedHeight: 300,
                            backgroundColor: Colors.transparent,
                            automaticallyImplyLeading: false,
                            title: Container(),
                            flexibleSpace: Container(height: 300),
                          ),
                        ];
                      },
                      body: BottomSheetContainer(
                        showHandle: true,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      // JobLogo(logoUrl: AppAssets.jobLogo2),
                                      // const SizedBox(width: 13),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              job.employer?.company_name ?? "",
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.lighterBlack,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                            const SizedBox(height: 6),
                                            Text(
                                              job.employer?.address ?? "",
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.lightBlack,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            // const SizedBox(height: 2),
                                            Text(
                                              "${miles.toInt()} mile${miles.toInt() == 1 ? "" : "s"} away",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.lightBlack
                                                    .withOpacity(0.6),
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                CustomPopup(
                                  options: menuOptions,
                                  logos: menuLogos,
                                  onSelected: toggleSelectOptions,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            JobDetailsTabbar(
                              tabs: tabs,
                              selectedTab: selectedTab,
                              onChanged: toggleTab,
                            ),

                            Expanded(
                              child: IndexedStack(
                                index: selectedTab,
                                children: [
                                  ListView(
                                    padding: const EdgeInsets.only(top: 30),
                                    primary: false,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    // physics: const ClampingScrollPhysics(),
                                    children: [
                                      JobInformationItem(
                                        title: "Job Description",
                                        value: job.summary,
                                      ),
                                      const SizedBox(height: 22),
                                      JobInformationItem(
                                        title: "Key Responsibilities",
                                        options: job.key_responsibilities,
                                      ),
                                      const SizedBox(height: 22),
                                      JobInformationItem(
                                        title: "Qualifications",
                                        options: job.qualifications,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        job.closing_statement,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.lightBlack,
                                        ),
                                      ),
                                      const SizedBox(height: 70),
                                    ],
                                  ),
                                  ListView(
                                    primary: false,
                                    physics: const ClampingScrollPhysics(),
                                    children: [
                                      const SizedBox(height: 16),

                                      Text(
                                        job.employer?.heading ?? "",
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.lightBlack,
                                        ),
                                      ),
                                      const SizedBox(height: 11),
                                      Text(
                                        job.employer?.body ?? "",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.lightBlack,
                                        ),
                                      ),
                                      const SizedBox(height: 11),
                                      Text(
                                        "Come make an impact that's uniquely you.",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.lightBlack,
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                    ],
                                  ),

                                  // ListView.separated(
                                  //   padding: const EdgeInsets.only(top: 30),
                                  //   shrinkWrap: true,
                                  //   // physics: const NeverScrollableScrollPhysics(),
                                  //   itemCount: activeJobWidgets.length,
                                  //   separatorBuilder: (context, index) {
                                  //     return const SizedBox(height: 26);
                                  //   },
                                  //   itemBuilder: (context, index) {
                                  //     final widget = activeJobWidgets[index];
                                  //     return widget;
                                  //   },
                                  // ),
                                  // const SizedBox(height: 50),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // if (selectedTab == 0)
                  Positioned(
                    bottom: 20,
                    left: 15,
                    right: 15,
                    child: ActionButton(
                      title: "Apply Now",
                      color: AppColors.lighterBlack,
                      onPressed: apply,
                    ),
                  ),
                ],
              ),
    );
  }
}
