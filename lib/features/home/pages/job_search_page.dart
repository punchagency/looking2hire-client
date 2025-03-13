import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/app_back_button.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/features/home/pages/locate_job_page.dart';
import 'package:looking2hire/features/home/widgets/search_result_item.dart';
import 'package:looking2hire/resusable/widgets/outlined_container.dart';

import '../../../app_colors.dart';
import '../models/job.dart';

class JobSearchPage extends StatefulWidget {
  const JobSearchPage({super.key});

  @override
  State<JobSearchPage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  final textController = TextEditingController();
  List<Job> jobs = [
    Job(
      company: "Full Stack Developer",
      desc: "Refers to a full stack developer with exceptional",
    ),
    Job(
      company: "Full Stack Developer",
      desc: "Refers to a full stack developer with exceptional",
    ),
    Job(
      company: "Full Stack Developer",
      desc: "Refers to a full stack developer with exceptional",
    ),
    Job(
      company: "Full Stack Developer",
      desc: "Refers to a full stack developer with exceptional",
    ),
    Job(
      company: "Full Stack Developer",
      desc: "Refers to a full stack developer with exceptional",
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void viewJob(Job job) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => LocateJobPage()));
  }
  // void searchJobs(String searchString) {}

  @override
  Widget build(BuildContext context) {
    final searchString = textController.text;
    final searchedJobs =
        jobs
            .where(
              (job) =>
                  job.company.toLowerCase().contains(
                    searchString.toLowerCase(),
                  ) ||
                  job.desc.toLowerCase().contains(searchString.toLowerCase()),
            )
            .toList();

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
                              onChanged: (text) {
                                setState(() {});
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(AppAssets.share),
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
            ],
          ),
        ),
      ),
    );
  }
}
