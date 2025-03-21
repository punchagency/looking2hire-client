import 'package:flutter/material.dart';
import 'package:looking2hire/components/app_dropdown.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/hire_container.dart';
import 'package:looking2hire/components/stat_card.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/widgets/applicant_card.dart';
import 'package:looking2hire/features/profile/hire_user_profile_page.dart';
import 'package:looking2hire/views/app_drawer.dart';
import 'package:looking2hire/views/stats_cards.dart';
import 'package:provider/provider.dart';

class JobApplicationsPage extends StatefulWidget {
  const JobApplicationsPage({super.key});

  @override
  State<JobApplicationsPage> createState() => _JobApplicationsPageState();
}

class _JobApplicationsPageState extends State<JobApplicationsPage> {
  List<String> options = ["Jobs Role", "Location", "Qualification"];
  String? selectedOption = "Jobs Role";

  void updateSelectedOption(String? value) {
    setState(() {
      selectedOption = value;
    });
  }

  void showApplications() {}
  void showChosenCandidates() {}
  void showInterviews() {}
  void showOffers() {}
  void showHiredCandidates() {}
  void showRejectedCandidates() {}

  void showApplicantProfile() {
    context.pushTo(HireUserProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = context.watch<JobProvider>();
    final job = jobProvider.job;
    // final applicantCards = [
    //   ApplicantCard(
    //     name: "Emily Carter",
    //     image: AppAssets.profilePicture3,
    //     experience: "5 years in UI/UX Design Figma, Adobe XD, Wireframing",
    //     date: "March 10, 2025",
    //     status: ApplicantStatus.shortlisted,
    //     onPressed: showApplicantProfile,
    //   ),
    //   ApplicantCard(
    //     name: "James Lee",
    //     image: AppAssets.profilePicture4,
    //     experience: "3 years in Product Design Sketch, InVision, Prototyping5",
    //     date: "March 15, 2025",
    //     status: ApplicantStatus.interviewed,
    //     onPressed: showApplicantProfile,
    //   ),
    // ];
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: "Applied Jobs",
      //   fontSize: 24,
      //   fontWeight: FontWeight.w600,
      //   centeredTitle: true,
      //   // needsDrawer: true,
      // ),
      // endDrawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            const SizedBox(height: 30),

            HireContainer(
              title: "Jobs Stats",
              child: StatsCards(
                cards: [
                  StatCard(
                    title: "Total Applications",
                    value: job?.applicationStats?.total.toString() ?? "0",
                    icon: AppAssets.users,
                    onPressed: showApplications,
                  ),

                  StatCard(
                    title: "Candidates Hired",
                    value: job?.applicationStats?.hired.toString() ?? "0",
                    icon: AppAssets.trophy,
                    onPressed: showHiredCandidates,
                  ),
                  StatCard(
                    title: "Candidates Rejected",
                    value: job?.applicationStats?.rejected.toString() ?? "0",
                    icon: AppAssets.close2,
                    onPressed: showRejectedCandidates,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            HireContainer(
              title: "Applicant Cards",
              //   child: ListView.separated(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemCount: job?.applications?.length ?? 0,
              //     separatorBuilder: (context, index) {
              //       return const SizedBox(height: 14);
              //     },
              //     itemBuilder: (context, index) {
              //       final application = job!.applications![index];
              //       return ApplicantCard(
              //         name: application.user.name,
              //         image: AppAssets.profilePicture4,
              //         experience: application.user.experience,
              //         date: application.createdAt,
              //         status: application.status,
              //         onPressed: showApplicantProfile,
              //       );
              //     },
              //   ),
            ),

            const SizedBox(height: 30),
            // HireContainer(
            //   title: "Saved Candidates",
            //   rightChild: AppDropdown(
            //     height: 40,
            //     width: 150,
            //     items: options,
            //     selectedItem: selectedOption,
            //     onChanged: updateSelectedOption,
            //   ),

            //   child: ListView.separated(
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: applicantCards.length,
            //     separatorBuilder: (context, index) {
            //       return const SizedBox(height: 14);
            //     },
            //     itemBuilder: (context, index) {
            //       final widget = applicantCards[index];
            //       return widget;
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
