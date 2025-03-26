import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/app_back_button.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/models/job.dart';
import 'package:looking2hire/features/home/pages/locate_job_page.dart';
import 'package:looking2hire/features/home/pages/work_job_details_page.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/widgets/search_result_item.dart';
import 'package:looking2hire/reuseable/widgets/outlined_container.dart';
import 'package:looking2hire/views/loading_or_message_view.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../../../app_colors.dart';

class JobSearchPage extends StatefulWidget {
  const JobSearchPage({super.key});

  @override
  State<JobSearchPage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  final textController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
    context.read<JobProvider>().searchedJobs = [];
  }

  @override
  void dispose() {
    textController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void viewJob(Job job) {
    final jobProvider = context.read<JobProvider>();
    jobProvider.job = job;
    context.pushTo(WorkJobDetailsPage());
  }

  void gotoMap() {
    context.pushTo(LocateJobPage());
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<JobProvider>().searchJob(title: query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = context.watch<JobProvider>();
    final searchedJobs = jobProvider.searchedJobs;
    // final searchString = textController.text;
    // final searchedJobs =
    //     jobs
    //         .where(
    //           (job) =>
    //               job.job_title.toLowerCase().contains(
    //                 searchString.toLowerCase(),
    //               ) ||
    //               job.summary.toLowerCase().contains(
    //                 searchString.toLowerCase(),
    //               ),
    //         )
    //         .toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  AppBackButton(),
                  // const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppAssets.search),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              autofocus: true,
                              controller: textController,
                              decoration: InputDecoration(
                                hintText: "Search jobs..",
                                hintStyle: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 0,
                                ),
                                isDense: true,
                              ),

                              style: TextStyle(
                                color: AppColors.lightBlack,
                                fontWeight: FontWeight.w400,
                              ),
                              onChanged: _onSearchChanged,
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
                  SizedBox(width: 8),
                  OutlinedContainer(child: SvgPicture.asset(AppAssets.filter)),
                ],
              ),
              const SizedBox(height: 14),
              Expanded(
                child: LoadingOrMessageView(
                  isLoading: jobProvider.isLoading,
                  message:
                      textController.text.isEmpty
                          ? "Search for jobs"
                          : "No jobs found",
                  showChild: searchedJobs.isNotEmpty,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchedJobs.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.dividerColor.withOpacity(0.12),
                        indent: 0,
                        endIndent: 0,
                      );
                    },
                    itemBuilder: (context, index) {
                      final job = searchedJobs[index];
                      return SearchResultItem(
                        job: job,
                        onPressed: () => viewJob(job),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
