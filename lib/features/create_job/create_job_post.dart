import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/create_job/views/create_or_edit_job_fields.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:provider/provider.dart';

class CreateJobPost extends StatefulWidget {
  const CreateJobPost({super.key});

  @override
  State<CreateJobPost> createState() => _CreateJobPostState();
}

class _CreateJobPostState extends State<CreateJobPost> {
  // void updateJobLocation(Prediction prediction) {
  //   final provider = context.read<JobProvider>();
  //   provider.jobLocationController.text = "${prediction.lat},${prediction.lng}";
  //   provider.jobAddressController.text = prediction.description ?? "";
  //   provider.jobAddressController.selection = TextSelection.fromPosition(
  //     TextPosition(offset: prediction.description?.length ?? 0),
  //   );
  // }

  void createJob() {
    final provider = context.read<JobProvider>();
    if (provider.formKey.currentState?.validate() == false) {
      return;
    }
    provider.createJob().then((job) {
      if (job != null) {
        setSnackBar(
          context: context,
          title: "Success",
          message: provider.successMessage,
        );
        context.pop();
        // context.pushReplacement(
        //   HireJobPostDetailsPage(job: job),
        // );
      } else {
        setSnackBar(
          context: context,
          title: "Error",
          message: provider.errorMessage,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Looking To Hire",
        arrowColor: AppColor.black,
      ),
      body: Consumer<JobProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48),
                CustomRobotoText(
                  text: "Create Job Post",
                  textSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                CustomRobotoText(
                  text:
                      "Provide job details to attract the right candidates and start hiring today.",
                  textSize: 16,
                  fontWeight: FontWeight.w400,
                  textColor: AppColor.grey[500],
                ),
                SizedBox(height: 32),
                CreateOrEditJobFields(),
                SizedBox(height: 40),
                Button(
                  onPressed: createJob,
                  text: "Generate Job",
                  block: true,
                  color: AppColor.buttonColor,
                ),
                SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
