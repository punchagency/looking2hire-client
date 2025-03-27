import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/action_button_with_icon.dart';
import 'package:looking2hire/components/app_progress_bar.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/dialog_container.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/extensions/scroll_controller_extensions.dart';
import 'package:looking2hire/features/create_job/create_job_post.dart';
import 'package:looking2hire/features/home/models/job.dart';
import 'package:looking2hire/features/home/pages/hire_job_display_page.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/home/widgets/active_job_item.dart';
import 'package:looking2hire/features/profile/components/profile_card.dart';
import 'package:looking2hire/features/profile/provider/user_provider.dart';
import 'package:looking2hire/features/profile/views/edit_employer_profile_fields.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:looking2hire/views/app_drawer.dart';
import 'package:provider/provider.dart';

class CompanyProfilePage extends StatefulWidget {
  const CompanyProfilePage({super.key});

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  final ScrollController _scrollController = ScrollController();

  void gotoEditProfile() {
    final userProvider = context.read<UserProvider>();
    userProvider.companyNameController.text =
        userProvider.employer?.company_name ?? "";
    userProvider.headingController.text = userProvider.employer?.heading ?? "";
    userProvider.emailController.text = userProvider.employer?.email ?? "";
    userProvider.bodyController.text = userProvider.employer?.body ?? "";
    //userProvider.companyLogoController.text = employer.company_logo ?? "";

    showDialog(
      context: context,
      builder: (context) {
        return DialogContainer(
          title: "Edit Profile",
          hint: "Update the employer details and save changes.",
          actions: [
            ActionButtonWithIcon(
              title: "Save Changes",
              onPressed: () {
                userProvider.updateEmployerDetails(context: context).then((
                  success,
                ) {
                  if (success) {
                    context.pop();
                    setSnackBar(
                      context: context,
                      title: "Success",
                      message: userProvider.successMessage,
                    );
                    //getEmployer();
                  } else {
                    setSnackBar(
                      context: context,
                      title: "Error",
                      message: userProvider.errorMessage,
                    );
                  }
                });
              },
            ),
          ],
          child: EditEmployerProfileFields(),
          // child: Column(
          //   // mainAxisSize: MainAxisSize.min,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     CustomIconTextField(
          //       textEditingController: TextEditingController(),
          //       textHint: "Upload Picture",
          //       icon: AppAssets.upload,
          //     ),
          //     SizedBox(height: 16),
          //     CustomIconTextField(
          //       textEditingController: userProvider.companyNameController,
          //       textHint: "Company Name",
          //       icon: AppAssets.user,
          //     ),
          //     // SizedBox(height: 16),
          //     // CustomIconTextField(
          //     //   textEditingController: userProvider.headingController,
          //     //   textHint: "Email",
          //     //   icon: AppAssets.briefcase,
          //     // ),
          //     SizedBox(height: 16),
          //     CustomIconTextField(
          //       textEditingController: userProvider.headingController,
          //       textHint: "Heading",
          //       icon: AppAssets.description,
          //     ),
          //     SizedBox(height: 16),
          //     CustomIconTextField(
          //       textEditingController: userProvider.descriptionController,
          //       textHint: "Body",
          //       icon: AppAssets.description,
          //     ),
          //   ],
          // ),
        );
      },
    );
  }

  void gotoAddJobPost() {
    context.pushTo(CreateJobPost());
    // context.pushTo(const HireJobPostDetailsPage());
  }

  void viewJob(Job job) {
    context.read<JobProvider>().job = job;
    context.pushTo(HireJobDisplayPage(job: job));
    // context.pushTo(JobOverviewPage());
  }

  void getJobs() async {
    // isLoading = true;
    // setState(() {});
    await Future.delayed(const Duration(milliseconds: 300));

    final jobProvider = context.read<JobProvider>();
    //jobPosts =
    await jobProvider.getJobPosts() ?? [];

    _scrollController.addOnScrollEndListener(() {
      jobProvider.getMoreJobPosts();
    });
  }

  void getEmployer() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final userProvider = context.read<UserProvider>();
    await userProvider.getEmployerProfile();
  }

  void editProfile() {
    // context.pushTo(EditProfilePage());
  }

  @override
  void initState() {
    super.initState();
    getJobs();
    getEmployer();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // void _onScroll() {
  //   if (_scrollController.position.pixels >=
  //       _scrollController.position.maxScrollExtent - 200) {}
  // }

  @override
  Widget build(BuildContext context) {
    final jobProvider = context.watch<JobProvider>();
    final userProvider = context.watch<UserProvider>();
    final employer = userProvider.employer;

    return Scaffold(
      appBar: CustomAppBar(
        title: appTitle,
        // arrowColor: AppColor.arrowColor,
        centeredTitle: false,
        fontWeight: FontWeight.w600,
        needsDrawer: true,
        canNotGoBack: true,
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileCard(
              name: employer?.company_name ?? "",
              address: employer?.address ?? "",
              imageUrl: employer?.company_logo ?? "",
              onEdit: gotoEditProfile,
            ),

            if ((employer?.heading ?? "").isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                employer?.heading ?? "",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack,
                ),
              ),
            ],
            if ((employer?.body ?? "").isNotEmpty) ...[
              const SizedBox(height: 11),
              Text(
                employer?.body ?? "",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlack,
                ),
              ),
            ],

            // const SizedBox(height: 11),
            // Text(
            //   "Come make an impact that's uniquely you.",
            //   style: const TextStyle(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w500,
            //     color: AppColors.lightBlack,
            //   ),
            // ),
            // if (jobProvider.isLoading) ...[
            //   const SizedBox(height: 20),
            //   Center(child: const AppProgressBar()),
            //   const SizedBox(height: 20),
            // ] else ...[
            SizedBox(height: 35),
            if (jobProvider.jobPosts.isEmpty) ...[
              ActionButtonWithIcon(
                title: "Add First Job Post",
                icon: AppAssets.addRounded,
                onPressed: gotoAddJobPost,
              ),

              const SizedBox(height: 30),
            ] else ...[
              ActionButtonWithIcon(
                title: "Create job",
                icon: AppAssets.bag,
                onPressed: gotoAddJobPost,
              ),
              const SizedBox(height: 20),
              Text(
                "Job Posts",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.lightBlack,
                ),
              ),
              const SizedBox(height: 14),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: jobProvider.jobPosts.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 26);
                },
                itemBuilder: (context, index) {
                  final job = jobProvider.jobPosts[index];
                  return ActiveJobItem(job: job, onPressed: () => viewJob(job));
                },
              ),

              SizedBox(height: 35),
            ],

            //],
            if (jobProvider.isLoading) ...[
              const SizedBox(height: 20),
              Center(child: const AppProgressBar()),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
