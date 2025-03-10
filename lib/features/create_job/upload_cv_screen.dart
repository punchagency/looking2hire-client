import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/views/app_drawer.dart';

class UploadCvScreen extends StatefulWidget {
  const UploadCvScreen({super.key});

  @override
  State<UploadCvScreen> createState() => _UploadCvScreenState();
}

class _UploadCvScreenState extends State<UploadCvScreen> {
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
        // rightChild: IconButton(
        //   icon: SvgPicture.asset(AppAssets.menu),
        //   onPressed: () {},
        // ),
      ),
      endDrawer: AppDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 56),
            CustomRobotoText(
              text: "Upload Your CV",
              textSize: 24,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 15),
            CustomText(
              text:
                  "Let AI enhance your profile by extracting key details from your resume.",
              textSize: 16,
              fontWeight: FontWeight.w400,
              textColor: AppColor.grey[500],
            ),
            SizedBox(height: 29),
            CustomLabelInputText(
              keyboardType: TextInputType.text,
              inputAction: TextInputAction.next,
              label: "",
              enabled: false,
              placeholder: "Select and upload your CV in PDF/DOC format",
            ),
            SizedBox(height: 8),
            CustomText(
              text:
                  "Our AI will analyze your CV and automatically fill in your profile details, saving you time!",
              textSize: 16,
              fontWeight: FontWeight.w400,
              textColor: AppColor.grey[500],
            ),
          ],
        ),
      ),
    );
  }
}
