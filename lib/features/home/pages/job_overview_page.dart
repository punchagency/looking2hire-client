import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/action_button_with_icon.dart';
import 'package:looking2hire/components/dialog_container.dart';
import 'package:looking2hire/components/job_detail.dart';
import 'package:looking2hire/components/rounded_icon_button.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/create_job/views/create_or_edit_job_fields.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/widgets/job_information_item.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:looking2hire/utils/date_utils.dart';
import 'package:looking2hire/views/edit_fields_view.dart';
import 'package:provider/provider.dart';

class JobOverviewPage extends StatefulWidget {
  const JobOverviewPage({super.key});

  @override
  State<JobOverviewPage> createState() => _JobOverviewPageState();
}

class _JobOverviewPageState extends State<JobOverviewPage> {
  void showEditResponsibilitiesDialog() {
    final jobProvider = context.read<JobProvider>();
    showDialog(
      context: context,
      builder: (context) {
        return EditFieldsView(
          title: "Responsibilities",
          options: jobProvider.job?.key_responsibilities ?? [],
          onSave: (options) => saveResponsibilities(options, context),
        );
      },
    );
  }

  void showEditQualificationsDialog() {
    final jobProvider = context.read<JobProvider>();
    showDialog(
      context: context,
      builder: (context) {
        return EditFieldsView(
          title: "Qualifications",
          options: jobProvider.job?.qualifications ?? [],
          onSave: (options) => saveQualifications(options, context),
        );
      },
    );
  }

  void saveQualifications(List<String> qualifications, BuildContext context) {
    final jobProvider = context.read<JobProvider>();
    jobProvider
        .updateJobPost(
          jobId: jobProvider.job?.id ?? "",
          qualifications: qualifications,
        )
        .then((success) {
          if (success) {
            setSnackBar(
              context: context,
              title: "Success",
              message: "Qualifications updated successfully",
            );
            context.pop();
          } else {
            setSnackBar(
              context: context,
              title: "Error",
              message: "Failed to update qualifications",
            );
          }
        });
  }

  void saveResponsibilities(
    List<String> responsibilities,
    BuildContext context,
  ) {
    final jobProvider = context.read<JobProvider>();
    jobProvider
        .updateJobPost(
          jobId: jobProvider.job?.id ?? "",
          key_responsibilities: responsibilities,
        )
        .then((success) {
          print("success = $success");
          if (success) {
            setSnackBar(
              context: context,
              title: "Success",
              message: "Responsibilities updated successfully",
            );
            context.pop();
          } else {
            setSnackBar(
              context: context,
              title: "Error",
              message: "Failed to update responsibilities",
            );
          }
        });
  }

  // void showEditClosingStatementDialog() {}

  void showEditJobPostDialog() {
    final jobProvider = context.read<JobProvider>();

    jobProvider.jobTitleController.text = jobProvider.job?.job_title ?? "";
    jobProvider.jobAddressController.text = jobProvider.job?.job_address ?? "";
    jobProvider.jobLocationController.text =
        "${jobProvider.job?.location?[0] ?? "0"},${jobProvider.job?.location?[1] ?? "0"}";
    // jobProvider.jobQualificationsController.text =
    //     jobProvider.job?.qualifications.firstOrNull ?? "";
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

    jobProvider.jobSummaryController.text = jobProvider.job?.summary ?? "";
    jobProvider.jobClosingStatementController.text =
        jobProvider.job?.closing_statement ?? "";

    showDialog(
      context: context,
      builder: (context) {
        return DialogContainer(
          title: "Edit Job Post",
          hint: "Update the job details and save changes.",
          actions: [
            ActionButtonWithIcon(
              title: "Save Changes",
              onPressed: () => saveJobPost(context),
            ),
          ],
          isScrollable: true,
          child: CreateOrEditJobFields(isEdit: true),
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

  void saveJobPost(BuildContext context) {
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
  void deactivate() {
    final jobProvider = context.read<JobProvider>();
    jobProvider.job = null;
    jobProvider.clearControllers();
    super.deactivate();
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
                        JobDetail(
                          title: "Job Title",
                          value: job.job_title ?? "",
                        ),
                        JobDetail(
                          title: "Company Name",
                          value: job.company_name ?? "",
                        ),
                        JobDetail(
                          title: "Description",
                          value: job.summary ?? "",
                        ),
                        JobDetail(
                          title: "Posted Time",
                          value:
                              "${job.createdAt?.formatDateToReadable()} • ${job.createdAt?.toTimeAgo}",
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
                              rightChild: RoundedIconButton(
                                onPressed: showEditResponsibilitiesDialog,
                                icon: AppAssets.editOutline,
                              ),
                            ),
                            const SizedBox(height: 11),
                            JobInformationItem(
                              title: "Qualifications:",
                              options: job.qualifications,
                              rightChild: RoundedIconButton(
                                onPressed: showEditQualificationsDialog,
                                icon: AppAssets.editOutline,
                              ),
                            ),
                            const SizedBox(height: 11),
                            Text(
                              job.closing_statement ?? "",
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
