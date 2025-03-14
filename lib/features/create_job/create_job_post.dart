import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/create_decal/decal_step1_screen.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/next_screen.dart';

class CreateJobPost extends StatefulWidget {
  const CreateJobPost({super.key});

  @override
  State<CreateJobPost> createState() => _CreateJobPostState();
}

class _CreateJobPostState extends State<CreateJobPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Looking To Hire",
        arrowColor: AppColor.black,
      ),
      body: SingleChildScrollView(
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
            CustomIconTextField(
              textEditingController: TextEditingController(),
              textHint: "Job Title",
              icon: AppAssets.briefcase,
            ),
            SizedBox(height: 16),
            CustomIconTextField(
              textEditingController: TextEditingController(),
              textHint: "Location",
              icon: AppAssets.location3,
            ),
            SizedBox(height: 16),
            CustomIconTextField(
              textEditingController: TextEditingController(),
              textHint: "Qualification need for the job",
              icon: AppAssets.graduation,
            ),
            SizedBox(height: 40),
            Button(
              onPressed: () {
                nextScreen(context, DecalStep1Screen());
              },
              text: "Generate Job",
              block: true,
              color: AppColor.buttonColor,
            ),
          ],
        ),
      ),
    );
  }
}
