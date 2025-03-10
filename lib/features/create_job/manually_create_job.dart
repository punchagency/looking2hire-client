import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/views/app_drawer.dart';

class ManuallyCreateJob extends StatefulWidget {
  const ManuallyCreateJob({super.key});

  @override
  State<ManuallyCreateJob> createState() => _ManuallyCreateJobState();
}

class _ManuallyCreateJobState extends State<ManuallyCreateJob> {
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
              text: "Add Your Job History",
              textSize: 24,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 15),
            CustomText(
              text:
                  "Showcase your experience to attract better job opportunities.",
              textSize: 16,
              fontWeight: FontWeight.w400,
              textColor: AppColor.grey[500],
            ),
            SizedBox(height: 29),
            CustomLabelInputText(
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              label: "",
              placeholder: "Job Heading",
            ),
            SizedBox(height: 18),
            CustomLabelInputText(
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              label: "",
              placeholder: "Job Description",
            ),
            SizedBox(height: 18),
            CustomLabelInputText(
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              label: "",
              placeholder: "Job Title",
            ),
            SizedBox(height: 18),
            CustomLabelInputText(
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              label: "",
              placeholder: "Employment Type",
            ),
            SizedBox(height: 18),
            CustomLabelInputText(
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              label: "",
              placeholder: "Company Name",
            ),
            SizedBox(height: 18),
            CustomLabelInputText(
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              label: "",
              placeholder: "Company Description",
            ),
            SizedBox(height: 18),
            CustomLabelInputText(
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              label: "",
              placeholder: "Start Date",
            ),
            SizedBox(height: 18),
            CustomLabelInputText(
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              label: "",
              placeholder: "End Date",
            ),
            SizedBox(height: 50),
            Button(
              onPressed: () {},
              text: "Save",
              textSize: 18,
              block: true,
              color: AppColor.buttonColor,
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
