import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/create_job/upload_cv_screen.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/views/app_drawer.dart';

class GetRelatedJobs extends StatefulWidget {
  const GetRelatedJobs({super.key});

  @override
  State<GetRelatedJobs> createState() => _GetRelatedJobsState();
}

class _GetRelatedJobsState extends State<GetRelatedJobs> {
  void sendLinkAndGotoCVUpload() {
    context.pushTo(UploadCvScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Looking To Work",
        arrowColor: AppColor.black,
        centeredTitle: true,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        needsDrawer: true,
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 56),
            CustomRobotoText(
              text: "Upload Your CV Securely",
              textSize: 24,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 15),
            CustomText(
              text: "Get better job matches by adding your resume.",
              textSize: 16,
              fontWeight: FontWeight.w400,
              textColor: AppColor.grey[500],
            ),
            SizedBox(height: 29),
            CustomLabelInputText(
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              label: "",
              placeholder: "Email",
            ),
            SizedBox(height: 50),
            Button(
              onPressed: sendLinkAndGotoCVUpload,
              text: "Send Link",
              textSize: 18,
              block: true,
              color: AppColor.buttonColor,
            ),
          ],
        ),
      ),
    );
  }
}
