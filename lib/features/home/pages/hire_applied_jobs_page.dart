import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/hire_container.dart';
import 'package:looking2hire/components/stat_card.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/widgets/applicant_card.dart';
import 'package:looking2hire/features/profile/hire_user_profile_page.dart';
import 'package:looking2hire/views/app_drawer.dart';
import 'package:looking2hire/views/stats_cards.dart';

class HireAppliedJobsPage extends StatefulWidget {
  const HireAppliedJobsPage({super.key});

  @override
  State<HireAppliedJobsPage> createState() => _HireAppliedJobsPageState();
}

class _HireAppliedJobsPageState extends State<HireAppliedJobsPage> {
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
    final applicantCards = [
      ApplicantCard(
        name: "Emily Carter",
        image: AppAssets.profilePicture3,
        experience: "5 years in UI/UX Design Figma, Adobe XD, Wireframing",
        date: "March 10, 2025",
        status: ApplicantStatus.shortlisted,
        onPressed: showApplicantProfile,
      ),
      ApplicantCard(
        name: "James Lee",
        image: AppAssets.profilePicture4,
        experience: "3 years in Product Design Sketch, InVision, Prototyping5",
        date: "March 15, 2025",
        status: ApplicantStatus.interviewed,
        onPressed: showApplicantProfile,
      ),
    ];
    return Scaffold(
      appBar: CustomAppBar(
        title: "Applied Jobs",
        fontSize: 24,
        fontWeight: FontWeight.w600,
        centeredTitle: true,
        // needsDrawer: true,
      ),
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
                    value: "120",
                    icon: AppAssets.users,
                    onPressed: showApplications,
                  ),
                  StatCard(
                    title: "Chosen Candidates",
                    value: "25",
                    icon: AppAssets.star,
                    onPressed: showChosenCandidates,
                  ),

                  StatCard(
                    title: "Interviews Conducted",
                    value: "60",
                    icon: AppAssets.calender,
                    onPressed: showInterviews,
                  ),
                  StatCard(
                    title: "Offers Extended",
                    value: "15",
                    icon: AppAssets.handshake,
                    onPressed: showOffers,
                  ),
                  StatCard(
                    title: "Candidates Hired",
                    value: "10",
                    icon: AppAssets.trophy,
                    onPressed: showHiredCandidates,
                  ),
                  StatCard(
                    title: "Candidates Rejected",
                    value: "35",
                    icon: AppAssets.close,
                    onPressed: showRejectedCandidates,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            HireContainer(
              title: "Applicant Cards",
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: applicantCards.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 14);
                },
                itemBuilder: (context, index) {
                  final widget = applicantCards[index];
                  return widget;
                },
              ),
            ),

            const SizedBox(height: 30),
            HireContainer(
              title: "Saved Candidates",
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: applicantCards.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 14);
                },
                itemBuilder: (context, index) {
                  final widget = applicantCards[index];
                  return widget;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
