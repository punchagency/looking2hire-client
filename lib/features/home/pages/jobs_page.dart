import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/enums/enums.dart';
import 'package:looking2hire/features/home/pages/job_display_page.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/home/widgets/active_job_item.dart';
import 'package:looking2hire/features/home/widgets/job_details_tabbar.dart';
import 'package:looking2hire/views/app_drawer.dart';

class JobsPage extends StatefulWidget {
  final JobType jobType;
  const JobsPage({super.key, required this.jobType});

  @override
  State<JobsPage> createState() => _JobsPageState();
}

class _JobsPageState extends State<JobsPage> {
  int selectedTab = 0;

  bool get isApplied => widget.jobType == JobType.applied;
  @override
  void initState() {
    super.initState();
    if (widget.jobType == JobType.viewed) {
      selectedTab = 1;
    }
  }

  void toggleTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  void viewJob() {
    context.pushTo(JobDisplayPage());
  }

  @override
  Widget build(BuildContext context) {
    const tabs = ["Saved Jobs", "Viewed Jobs"];

    final activeJobWidgets = [
      ActiveJobItem(
        title: "Sales Associate",
        desc: "Description duis aute irure dolor in reprehenderit.....",
        date: "Today",
        time: "23 min",
        status: JobStatus.available,
        onPressed: viewJob,
      ),
      ActiveJobItem(
        title: "Designer Consultant",
        desc: "Description duis aute irure dolor in reprehenderit.....",
        date: "Today",
        time: "23 min",
        status: JobStatus.ended,

        onPressed: viewJob,
      ),
      ActiveJobItem(
        title: "Product Manager",
        desc:
            "Leading cross-functional teams to deliver product strategies and roadmaps.",
        date: "Today",
        time: "30 min",
        status: JobStatus.available,

        onPressed: viewJob,
      ),
      ActiveJobItem(
        title: "Marketing Specialist",
        desc:
            "Focusing on market research and campaign management to drive brand awareness.",
        date: "Today",
        time: "45 min",
        status: JobStatus.ended,

        onPressed: viewJob,
      ),
      ActiveJobItem(
        title: "Data Analyst",
        desc:
            "Analyzing complex datasets to provide insights and improve business performance.",
        date: "Today",
        time: "1 hour",
        status: JobStatus.available,

        onPressed: viewJob,
      ),

      ActiveJobItem(
        title: "Content Strategist",
        desc:
            "Developing engaging content plans to improve user experience and SEO.",
        date: "Today",
        time: "1 hour",
        status: JobStatus.available,
        onPressed: viewJob,
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title:
            "${isApplied
                ? "Applied"
                : selectedTab == 0
                ? "Saved"
                : "Viewed"} Jobs",
        centeredTitle: true,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        // needsDrawer: true,
      ),
      // endDrawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 20),

            if (!isApplied) ...[
              JobDetailsTabbar(
                tabs: tabs,
                selectedTab: selectedTab,
                onChanged: toggleTab,
              ),
              const SizedBox(height: 16),
            ],

            Expanded(
              child: ListView.separated(
                // padding: const EdgeInsets.only(top: 30),
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: activeJobWidgets.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 26);
                },
                itemBuilder: (context, index) {
                  final widget = activeJobWidgets[index];
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
