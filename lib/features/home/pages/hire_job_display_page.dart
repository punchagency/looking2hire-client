import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/features/home/models/job.dart';
import 'package:looking2hire/features/home/pages/job_applications_page.dart';
import 'package:looking2hire/features/home/pages/job_overview_page.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/widgets/job_details_tabbar.dart';
import 'package:provider/provider.dart';

class HireJobDisplayPage extends StatefulWidget {
  final Job job;
  const HireJobDisplayPage({super.key, required this.job});

  @override
  State<HireJobDisplayPage> createState() => _HireJobDisplayPageState();
}

class _HireJobDisplayPageState extends State<HireJobDisplayPage> {
  int selectedTab = 0;
  void toggleTab(int tab) {
    setState(() {
      selectedTab = tab;
    });
  }

  void getJobPost() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final jobProvider = context.read<JobProvider>();
    jobProvider.getJobPost(jobId: widget.job.id);
  }

  @override
  void initState() {
    super.initState();
    getJobPost();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ["Job Overvew", "Applications"];
    final jobProvider = context.watch<JobProvider>();

    return Scaffold(
      appBar: CustomAppBar(
        title: "Job Post",
        centeredTitle: true,
        fontSize: 24,
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: JobDetailsTabbar(
              tabs: tabs,
              selectedTab: selectedTab,
              onChanged: toggleTab,
            ),
          ),
          Expanded(
            child:
                jobProvider.isLoading
                    ? Container()
                    : IndexedStack(
                      index: selectedTab,
                      children: const [
                        JobOverviewPage(),
                        JobApplicationsPage(),
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}
