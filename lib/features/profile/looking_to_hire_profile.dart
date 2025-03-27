import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/action_button_with_icon.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/dialog_container.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/home/utils/utils.dart';
import 'package:looking2hire/features/profile/components/profile_job_history_card.dart';
import 'package:looking2hire/features/profile/model/applicant_profile.dart';
import 'package:looking2hire/features/profile/provider/user_provider.dart';
import 'package:looking2hire/reuseable/widgets/round_image.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:looking2hire/utils/date_formart.dart';
import 'package:looking2hire/views/profile_upload_view.dart';
import 'package:provider/provider.dart';

import '../home/widgets/job_information_item.dart';

class LookingToHireProfile extends StatefulWidget {
  const LookingToHireProfile({super.key});

  @override
  State<LookingToHireProfile> createState() => _LookingToHireProfileState();
}

class _LookingToHireProfileState extends State<LookingToHireProfile> {
  final TextEditingController _startDateController2 = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController2 = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final String formattedDate =
          "${picked.day}/${picked.month}/${picked.year}";
      setState(() {
        if (isStartDate) {
          _startDateController.text = formattedDate;
          _startDateController2.text = picked.toString();
        } else {
          _endDateController.text = formattedDate;
          _endDateController2.text = picked.toString();
        }
      });
    }
  }

  final jobHistoryWidgets = [
    ProfileJobHistoryCard(
      companyLogo: AppAssets.apple,
      jobTitle: "West Elm - Retail Sales",
      jobDescription: "Description duis aute irure dolor.....",
      startDate: "Feb 2023",
      endDate: "Jan 2023",
    ),

    ProfileJobHistoryCard(
      companyLogo: AppAssets.gap,
      jobTitle: "West Elm - Retail Sales",
      jobDescription: "Description duis aute irure dolor.....",
      startDate: "Feb 2023",
      endDate: "Jan 2023",
      isSaved: true,
    ),

    ProfileJobHistoryCard(
      companyLogo: AppAssets.bananaRepublic,
      jobTitle: "West Elm - Retail Sales",
      jobDescription: "Description duis aute irure dolor.....",
      startDate: "Feb 2023",
      endDate: "Jan 2023",
    ),
  ];
  void selectImage(String filePath) {
    final userProvider = context.read<UserProvider>();
    userProvider.filePathController.text = filePath;
  }

  void removeImage() {
    final userProvider = context.read<UserProvider>();
    userProvider.companyLogoController.text = "";
  }

  void gotoEditProfile(UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogContainer(
          title: "Edit Profile",
          hint: "Update your profile details and save changes.",
          actions: [
            ActionButtonWithIcon(
              title: "Save Changes",
              onPressed: () {
                userProvider.updateApplicantDetails(context: context).then((
                  success,
                ) {
                  if (success) {
                    context.pop();
                    setSnackBar(
                      context: context,
                      title: "Success",
                      message: userProvider.successMessage,
                    );
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
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileUploadView(
                imageUrl: userProvider.profilePicController.text,
                onRemove: removeImage,
                onSelect: selectImage,
              ),
              // CustomIconTextField(
              //   textEditingController: TextEditingController(),
              //   textHint: "Upload Picture",
              //   icon: AppAssets.upload,
              // ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: userProvider.fullNameController,
                textHint: "Name",
                icon: AppAssets.user,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: userProvider.headingController,
                textHint: "Title",
                icon: AppAssets.briefcase,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: userProvider.descriptionController,
                textHint: "Description",
                icon: AppAssets.description,
              ),
            ],
          ),
        );
      },
    );
  }

  void gotoEditJobHistory(UserProvider userProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return DialogContainer(
          title: "Edit Job",
          hint: "Update the job details and save changes.",
          actions: [
            ActionButtonWithIcon(
              title: "Save Changes",
              onPressed: () {
                userProvider.updateApplicantJobHistory(context: context).then((
                  success,
                ) {
                  if (success) {
                    context.pop();
                    setSnackBar(
                      context: context,
                      title: "Success",
                      message: userProvider.successMessage,
                    );
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
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileUploadView(
                imageUrl: userProvider.companyLogoController.text,
                onRemove: removeImage,
                onSelect: selectImage,
              ),
              // CustomIconTextField(
              //   textEditingController: TextEditingController(),
              //   textHint: "Upload Picture",
              //   icon: AppAssets.upload,
              // ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: userProvider.jobTitleController,
                textHint: "Job Title",
                icon: AppAssets.briefcase,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: userProvider.companyNameController,
                textHint: "Company Name",
                icon: AppAssets.briefcase,
              ),
              SizedBox(height: 16),

              CustomIconTextField(
                textEditingController: userProvider.jobDescriptionController,
                textHint: "Job Description",
                icon: AppAssets.description,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: userProvider.jobStartDateController,
                textHint: "Date of Joining",
                icon: AppAssets.calender2,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: userProvider.jobEndDateController,
                textHint: "Date of Leaving",
                icon: AppAssets.calender2,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final provider = context.read<UserProvider>();
    provider.getApplicantProfile();
    provider.descriptionController.text =
        provider.applicantProfile.user?.description ?? "";
    provider.headingController.text =
        provider.applicantProfile.user?.heading ?? "";
    provider.fullNameController.text =
        provider.applicantProfile.user?.name ?? "";
  }

  Future<void> initJobHistory() async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    provider.jobTitleController.text =
        provider.employmentHistory.jobTitle ?? "";
    provider.jobDescriptionController.text =
        provider.employmentHistory.description ?? "";
    provider.jobStartDateController.text = formatDateString2(
      provider.employmentHistory.startDate.toString(),
    );
    provider.jobEndDateController.text = formatDateString2(
      provider.employmentHistory.endDate.toString(),
    );
    provider.employmentTypeController.text =
        provider.employmentHistory.employmentType ?? "";
    provider.companyNameController.text =
        provider.employmentHistory.companyName ?? "";
    provider.filePathController.text =
        provider.employmentHistory.companyLogo ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: appTitle,
            arrowColor: AppColor.arrowColor,
            centeredTitle: true,
            fontWeight: FontWeight.w600,
            // needsDrawer: true,
          ),
          // endDrawer: AppDrawer(),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ProfileCard(
                //   name: "Michael Smith",
                //   address: "Hallandale Beach, FL 33009",
                //   milesAway: 0.5,
                // ),
                Row(
                  children: [
                    RoundedImage(
                      imageUrl:
                          provider.applicantProfile.user?.profilePic ?? "",
                      size: 80,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        provider.applicantProfile.user?.name ?? "Michael Smith",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightBlack,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        gotoEditProfile(provider);
                      },
                      icon: SvgPicture.asset(AppAssets.edit),
                    ),
                  ],
                ),
                SizedBox(height: 14),
                JobInformationItem(
                  title:
                      provider.applicantProfile.user?.heading ??
                      "Reliable and hardworking, expert in retail sales.",
                  fontSize: 22,
                  value: provider.applicantProfile.user?.description ?? "",
                  // "I am a reliable and hardworking professional with expertise in retail sales. I excel at providing excellent customer service, driving sales and building lasting customer relationships. With a strong work ethic and a focus in results, I am committed to contributing to the success of any team I join.",
                ),
                SizedBox(height: 35),
                Text(
                  "Job History",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightBlack,
                  ),
                ),
                const SizedBox(height: 14),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      provider
                          .applicantProfile
                          .user
                          ?.employmentHistory
                          ?.length ??
                      0,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 15);
                  },
                  itemBuilder: (context, index) {
                    final data =
                        provider
                            .applicantProfile
                            .user
                            ?.employmentHistory?[index];
                    return ProfileJobHistoryCard(
                      companyLogo: data?.companyLogo ?? "",
                      isNetworkImage: true,
                      jobTitle:
                          "${data?.companyName ?? ""} - ${data?.jobTitle ?? ""}",
                      jobDescription:
                          data?.description ??
                          "Description duis aute irure dolor.....",
                      startDate: formatDateString2(
                        data?.startDate.toString() ?? DateTime.now().toString(),
                      ),
                      endDate: formatDateString2(
                        data?.endDate.toString() ?? DateTime.now().toString(),
                      ),
                      onPressed: () {
                        provider.employmentHistory =
                            data ?? EmploymentHistory();
                        initJobHistory();
                        gotoEditJobHistory(provider);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
