import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/action_button_with_icon.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/dialog_container.dart';
import 'package:looking2hire/components/hire_container.dart';
import 'package:looking2hire/components/job_detail.dart';
import 'package:looking2hire/components/rounded_icon_button.dart';
import 'package:looking2hire/components/title_information.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/create_job/views/create_job_fields.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/widgets/action_button.dart';
import 'package:looking2hire/features/home/widgets/job_information_item.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:looking2hire/utils/date_utils.dart';
import 'package:provider/provider.dart';

import '../models/job.dart';

class JobOverviewPage extends StatefulWidget {
  const JobOverviewPage({super.key});

  @override
  State<JobOverviewPage> createState() => _JobOverviewPageState();
}

class _JobOverviewPageState extends State<JobOverviewPage> {
  void applyForJob() {}

  void showEditJobPostDialog() {
    final jobProvider = context.read<JobProvider>();

    jobProvider.jobTitleController.text = jobProvider.job?.job_title ?? "";
    jobProvider.jobAddressController.text = jobProvider.job?.job_address ?? "";
    jobProvider.jobLocationController.text =
        "${jobProvider.job?.location[0]},${jobProvider.job?.location[1]}";
    jobProvider.jobQualificationsController.text =
        jobProvider.job?.qualifications.firstOrNull ?? "";
    jobProvider.jobSalaryCurrencyController.text =
        jobProvider.job?.salary_currency ?? "USD";
    jobProvider.jobSalaryMinController.text =
        jobProvider.job?.salary_min?.toString() ?? "";
    jobProvider.jobSalaryMaxController.text =
        jobProvider.job?.salary_max?.toString() ?? "";
    jobProvider.jobSeniorityController.text = jobProvider.job?.seniority ?? "";
    jobProvider.jobEmploymentTypeController.text =
        jobProvider.job?.employment_type ?? "";
    jobProvider.jobWorkTypeController.text = jobProvider.job?.work_type ?? "";
    jobProvider.jobSalaryPeriodController.text =
        jobProvider.job?.salary_period ?? "";

    showDialog(
      context: context,
      builder: (context) {
        return DialogContainer(
          title: "Edit Job Post",
          hint: "Update the job details and save changes.",
          actions: [
            ActionButtonWithIcon(title: "Save Changes", onPressed: saveJobPost),
          ],
          child: SingleChildScrollView(child: CreateJobFields()),
        );
      },
    );
  }

  void showDeleteJobPostDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogContainer(
          title: "Delete Job Post",
          message:
              "Are you sure you want to delete this job post? This action cannot be undone.",
          actions: [
            ActionButtonWithIcon(
              title: "Delete",
              isDestructive: true,
              icon: AppAssets.trash,
              onPressed: deleteJobPost,
            ),
            ActionButtonWithIcon(
              title: "Cancel",
              icon: AppAssets.close2,
              onPressed: () => context.pop(),
            ),
          ],
        );
      },
    );
  }

  void saveJobPost() {
    final jobProvider = context.read<JobProvider>();
    jobProvider.updateJobPost(jobId: jobProvider.job?.id ?? "").then((success) {
      if (success) {
        setSnackBar(
          context: context,
          title: "Success",
          message: jobProvider.successMessage,
        );
        context.pop();
      } else {
        setSnackBar(
          context: context,
          title: "Error",
          message: jobProvider.errorMessage,
        );
      }
    });
  }

  void deleteJobPost() {
    final jobProvider = context.read<JobProvider>();
    jobProvider.deleteJobPost(jobId: jobProvider.job?.id ?? "").then((success) {
      if (success) {
        setSnackBar(
          context: context,
          title: "Success",
          message: jobProvider.successMessage,
        );
        context.pop();
        context.pop();
      } else {
        setSnackBar(
          context: context,
          title: "Error",
          message: jobProvider.errorMessage,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //getJobPost();
  }

  @override
  Widget build(BuildContext context) {
    final jobProvider = context.watch<JobProvider>();
    final job = jobProvider.job;
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: jobProvider.job?.job_title ?? "",
      //   centeredTitle: true,
      //   fontSize: 24,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child:
            jobProvider.isLoading
                ? Container()
                : job == null
                ? Container()
                // ? const Center(child: Text("Job Post Deleted"))
                : Stack(
                  children: [
                    ListView(
                      children: [
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Job Overview",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.lightBlack,
                                ),
                              ),
                            ),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RoundedIconButton(
                                  onPressed: showEditJobPostDialog,
                                  icon: AppAssets.editOutline,
                                ),
                                const SizedBox(width: 16),
                                RoundedIconButton(
                                  onPressed: showDeleteJobPostDialog,
                                  icon: AppAssets.trash,
                                  color: Colors.red,
                                ),
                              ],
                            ),

                            // IconButton(
                            //   onPressed: showEditJobPostDialog,
                            //   icon: SvgPicture.asset(AppAssets.editOutline),
                            // ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        JobDetail(title: "Job Title", value: job.job_title),
                        JobDetail(
                          title: "Company Name",
                          value: job.company_name ?? "",
                        ),
                        JobDetail(title: "Description", value: job.summary),
                        JobDetail(
                          title: "Posted Time",
                          value:
                              "${job.createdAt.formatDateToReadable()} • ${job.createdAt.toTimeAgo}",
                        ),
                        const SizedBox(height: 32),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // const SizedBox(height: 11),
                            // Text(
                            //   "Crate & Barrel is seeking a friendly and motivates Sales Associate to join our team. In this role, you will provide exceptional customer service, help customers find the perfect furniture and home decor and create a welcoming shopping experience.",
                            //   style: const TextStyle(
                            //     fontSize: 14,
                            //     fontWeight: FontWeight.w400,
                            //     color: AppColors.lightBlack,
                            //   ),
                            // ),
                            JobInformationItem(
                              title: "Key Responsibilities:",
                              options: job.key_responsibilities,
                              // options: [
                              //   "Assist customers with product inquires, selections and purchases.",
                              //   "Maintain product knowledge of furniture, home decor and seasonal collections.",
                              //   "Collaborate with team members to meet store sales goals.",
                              //   "Ensure display and merchandise are well-organized and visually appealing.",
                              //   "Process transactions, returns and exchanges efficiently.",
                              // ],
                            ),
                            const SizedBox(height: 11),
                            JobInformationItem(
                              title: "Qualifications:",
                              options: job.qualifications,
                              // options: [
                              //   "Strong communication and customer service skills.",
                              //   "Ability to work in a fast-paces, team-oriented environment.",
                              //   "Prior retail or sales experience (preferred).",
                              //   "Passion for interior design and home furnishings.",
                              // ],
                            ),
                            const SizedBox(height: 11),
                            Text(
                              job.closing_statement,
                              // """Join us at Crate & Barrel and inspire customers to deign beautiful, functional spaces!""",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightBlack,
                              ),
                            ),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ],
                    ),
                    // Positioned(
                    //   bottom: 20,
                    //   left: 0,
                    //   right: 0,
                    //   child: ActionButton(
                    //     title: "Apply Now",
                    //     color: AppColors.lighterBlack,
                    //     onPressed: applyForJob,
                    //   ),
                    // ),
                  ],
                ),
      ),
    );
  }
}
