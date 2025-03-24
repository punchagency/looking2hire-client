import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/constants/app_colors.dart';
import 'package:looking2hire/components/bottom_sheet_container.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_popup.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/pages/active_jobs_page.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/widgets/action_button.dart';
import 'package:looking2hire/features/home/widgets/job_details_tabbar.dart';
import 'package:looking2hire/features/home/widgets/job_information_item.dart';
import 'package:looking2hire/features/home/widgets/job_logo.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:provider/provider.dart';

class HireJobDetailsPage extends StatefulWidget {
  const HireJobDetailsPage({super.key});

  @override
  State<HireJobDetailsPage> createState() => _HireJobDetailsPageState();
}

class _HireJobDetailsPageState extends State<HireJobDetailsPage> {
  int selectedTab = 0;
  List<String> menuOptions = ["Save", "Share"];
  List<String> menuLogos = [AppAssets.save2, AppAssets.share2];

  void toggleTab(int tab) {
    // if (tab == 1) {
    //   // context.pushTo(ActiveJobsPage());
    // } else {}
    setState(() {
      selectedTab = tab;
    });
  }

  void toggleSelectOptions(String option) {}

  void apply() {}

  @override
  Widget build(BuildContext context) {
    const tabs = ["Description", "Company"];
    return Consumer<JobProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            title: "Job Details",
            titleColor: Colors.white,
            arrowColor: Colors.white,
            centeredTitle: true,
            fontSize: 26,
          ),
          body: SizedBox.expand(
            child: Stack(
              children: [
                SizedBox(
                  height: 380,
                  child: Image.asset(AppAssets.jobDetailsImage, fit: BoxFit.cover),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerScrolled) {
                      return [
                        SliverAppBar(
                          expandedHeight: 180,
                          collapsedHeight: 180,
                          backgroundColor: Colors.transparent,
                          automaticallyImplyLeading: false,
                          title: Container(),
                          flexibleSpace: Container(height: 180),
                          floating: true,
                          snap: true,
                        ),
                      ];
                    },
                    body: Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: BottomSheetContainer(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      JobLogo(logoUrl: AppAssets.jobLogo2),
                                      const SizedBox(width: 13),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              provider.recommendedJob.jobTitle ?? '',
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.lighterBlack,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  AppAssets.location2,
                                                ),
                                                const SizedBox(width: 6),
                                                Expanded(
                                                  child: Text(
                                                    provider.recommendedJob.jobAddress ?? "71 Elmwood Avenue",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.lighterBlack,
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                            const SizedBox(height: 30),

                            JobDetailsTabbar(
                              tabs: tabs,
                              selectedTab: selectedTab,
                              onChanged: toggleTab,
                            ),

                            selectedTab == 0 ? Expanded(
                              child: ListView(
                                primary: true,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                children: [
                                  const SizedBox(height: 30),

                                  JobInformationItem(
                                    title: "Job Description",
                                    value:
                                    provider.recommendedJob.summary ?? "Project managers play the lead role in planning, executing, monitoring, controlling, and closing out projects. They are accountable for the entire project scope, the project team and resources, the project budget, and the success or failure of the project.",
                                  ),
                                  const SizedBox(height: 22),
                                  JobInformationItem(
                                    title: "Requirements",
                                    options: provider.recommendedJob.keyResponsibilities ?? [
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
                            ) : Expanded(child: ListView(
                              primary: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              children: [
                                const SizedBox(height: 30),
                                JobInformationItem(
                                  title: "We have everything we need to inspire our customers. Except you.",
                                  fontSize: 24,
                                  value:
                                  // provider.recommendedJob.summary ??
                                      "We inspire purpose-filled living that brings joy to the modern home. With a team of more than 8,000 associates spanning 130 store and distribution locations across the U.S and Canada, we achieve together, drive results and innovate to inspire. Drawn together by a shared passion of our customers and a spirit of fun, we deliver high-quality home furnishings that are expertly designed, responsibly sourced and bring beauty and function to people’s homes. From the day we opened our first store in Chicago in 1962 to the digital innovations that engage millions of customers today, our iconic brand is nearly 60 years in the making and our story is unfolding.\n\nCome make an impact that’s uniquely you.",
                                ),
                                const SizedBox(height: 70),
                              ],
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 15,
                  right: 15,
                  child: ActionButton(
                    title: "Apply Now",
                    color: AppColors.lighterBlack,
                    onPressed: (){
                      provider.applyForJob(jobId: provider.recommendedJob.id ?? "").then((success){
                        if(success){
                          setSnackBar(context: context, title: "Success", message: provider.successMessage);
                        } else {
                          setSnackBar(context: context, title: "Error", message: provider.errorMessage);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
