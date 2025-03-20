import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/action_button_with_icon.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/dialog_container.dart';
import 'package:looking2hire/components/hire_container.dart';
import 'package:looking2hire/components/job_detail.dart';
import 'package:looking2hire/components/title_information.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/widgets/action_button.dart';
import 'package:looking2hire/features/home/widgets/job_information_item.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:looking2hire/utils/date_utils.dart';
import 'package:provider/provider.dart';

import '../models/job.dart';

class JobCardPage extends StatefulWidget {
  final Job job;
  const JobCardPage({super.key, required this.job});

  @override
  State<JobCardPage> createState() => _JobCardPageState();
}

class _JobCardPageState extends State<JobCardPage> {
  void applyForJob() {}

  void showEditJobPostDialog() {
    final jobProvider = context.read<JobProvider>();
    jobProvider.jobTitleController.text = widget.job.job_title;
    jobProvider.jobAddressController.text = widget.job.job_address;
    jobProvider.jobLocationController.text =
        "${widget.job.location[0]},${widget.job.location[1]}";
    jobProvider.jobQualificationsController.text =
        widget.job.qualifications.firstOrNull ?? "";
    showDialog(
      context: context,
      builder: (context) {
        return DialogContainer(
          title: "Edit Job Post",
          hint: "Update the job details and save changes.",
          actions: [
            ActionButtonWithIcon(title: "Save Changes", onPressed: saveJobPost),
          ],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomIconTextField(
                textEditingController: jobProvider.jobTitleController,
                textHint: "Job Title",
                icon: AppAssets.briefcase,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: jobProvider.jobLocationController,
                textHint: "Location",
                icon: AppAssets.location3,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: jobProvider.jobQualificationsController,
                textHint: "Qualification need for the job",
                icon: AppAssets.graduation,
              ),
            ],
          ),
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
          hint: "",
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
    jobProvider.updateJobPost(jobId: widget.job.id).then((success) {
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
    jobProvider.deleteJobPost(jobId: widget.job.id).then((success) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Sales Associate",
        centeredTitle: true,
        fontSize: 24,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
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
                    IconButton(
                      onPressed: showEditJobPostDialog,
                      icon: SvgPicture.asset(AppAssets.editOutline),
                    ),
                  ],
                ),
                JobDetail(title: "Job Title", value: widget.job.job_title),
                JobDetail(title: "Company Name", value: "Crate & Barrel"),
                JobDetail(title: "Description", value: widget.job.summary),
                JobDetail(
                  title: "Posted Time",
                  value:
                      "${widget.job.createdAt.formatDateToReadable()} • ${widget.job.createdAt.toTimeAgo}",
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
                      options: widget.job.key_responsibilities,
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
                      options: widget.job.qualifications,
                      // options: [
                      //   "Strong communication and customer service skills.",
                      //   "Ability to work in a fast-paces, team-oriented environment.",
                      //   "Prior retail or sales experience (preferred).",
                      //   "Passion for interior design and home furnishings.",
                      // ],
                    ),
                    const SizedBox(height: 11),
                    Text(
                      widget.job.closing_statement,
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
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: ActionButton(
                title: "Apply Now",
                color: AppColors.lighterBlack,
                onPressed: applyForJob,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
