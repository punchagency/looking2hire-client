import 'package:flutter/material.dart';
import 'package:looking2hire/components/bottom_sheet_container.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_popup.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_colors.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/pages/job_display_page.dart';
import 'package:looking2hire/features/home/widgets/action_button.dart';
import 'package:looking2hire/features/home/widgets/active_job_item.dart';
import 'package:looking2hire/features/home/widgets/job_details_tabbar.dart';
import 'package:looking2hire/features/home/widgets/job_information_item.dart';

class WorkJobDetailsPage extends StatefulWidget {
  const WorkJobDetailsPage({super.key});

  @override
  State<WorkJobDetailsPage> createState() => _WorkJobDetailsPageState();
}

class _WorkJobDetailsPageState extends State<WorkJobDetailsPage> {
  List<String> menuOptions = ["Save", "Share"];
  List<String> menuLogos = [AppAssets.save2, AppAssets.share2];

  int selectedTab = 0;
  void toggleTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  void toggleSelectOptions(String option) {}

  void apply() {}

  void viewJob() {
    context.pushTo(JobDisplayPage());
  }

  @override
  Widget build(BuildContext context) {
    const tabs = ["Job Details", "Company"];

    final activeJobWidgets = [
      // ActiveJobItem(
      //   title: "Sales Associate",
      //   desc: "Description duis aute irure dolor in reprehenderit.....",
      //   date: "Today",
      //   time: "23 min",
      //   onPressed: viewJob,
      // ),
      // ActiveJobItem(
      //   title: "Designer Consultant",
      //   desc: "Description duis aute irure dolor in reprehenderit.....",
      //   date: "Today",
      //   time: "23 min",
      //   onPressed: viewJob,
      // ),
      // ActiveJobItem(
      //   title: "Product Manager",
      //   desc:
      //       "Leading cross-functional teams to deliver product strategies and roadmaps.",
      //   date: "Today",
      //   time: "30 min",
      //   onPressed: viewJob,
      // ),
      // ActiveJobItem(
      //   title: "Marketing Specialist",
      //   desc:
      //       "Focusing on market research and campaign management to drive brand awareness.",
      //   date: "Today",
      //   time: "45 min",
      //   onPressed: viewJob,
      // ),
      // ActiveJobItem(
      //   title: "Data Analyst",
      //   desc:
      //       "Analyzing complex datasets to provide insights and improve business performance.",
      //   date: "Today",
      //   time: "1 hour",
      //   onPressed: viewJob,
      // ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: "Looking To Work",
        centeredTitle: true,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        // needsDrawer: true,
      ),
      // endDrawer: AppDrawer(),
      body: Stack(
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
                  image: AssetImage(AppAssets.crateAndBarrelImage),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Crate & Barrel",
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
                                      "Hallandale Beach, FL 33009\n600 Silks Run",
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
                                      "0.5 Miles Away",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.lightBlack.withOpacity(
                                          0.6,
                                        ),
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
                            physics: const ClampingScrollPhysics(),
                            children: [
                              JobInformationItem(
                                title: "Job Description",
                                value:
                                    "Project managers play the lead role in planning, executing, monitoring, controlling, and closing out projects. They are accountable for the entire project scope, the project team and resources, the project budget, and the success or failure of the project.",
                              ),
                              const SizedBox(height: 22),
                              JobInformationItem(
                                title: "Requirements",
                                options: [
                                  "Bachelor's degree in computer science, business, or a related field",
                                  "5-8 years of project management and related experience",
                                  "Project Management Professional (PMP) certification preferred",
                                  "Proven ability to solve problems creatively",
                                  "Strong familiarity with project management software tools, methodologies, and best practices",
                                  "Experience seeing projects through the full life cycle",
                                ],
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
                                "We have everything we need to inspire our customers. Except you.",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.lightBlack,
                                ),
                              ),
                              const SizedBox(height: 11),
                              Text(
                                """We inspire purpose-filled living that brings joy to the modern home. With a team of more than 8,000 associates spanning 130 store and distribution locations across the U.S and Canada, we achieve together, drive results and innovate to inspire. Drawn together by a shared passion of our customers and a spirit of fun, we deliver high-quality home furnishings that are expertly designed, responsibly sourced and bring beauty and function to people's homes. From the day we opened our first store in Chicago in 1962 to the digital innovations that engage millions of customers today, our iconic brand is nearly 60 years in the making and our story is unfolding.
Come make an impact that's uniquely you.""",
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
