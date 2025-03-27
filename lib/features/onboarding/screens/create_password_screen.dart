import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/next_screen.dart';

import '../../profile/company_profile_page.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Looking To Hire!",
        arrowColor: AppColor.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32),
              CustomRobotoText(
                text: "Set Password",
                textSize: 24,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                text:
                    "Create a secure password to protect your account and ensure safe access.",
                textSize: 16,
                fontWeight: FontWeight.w400,
                textColor: AppColor.grey[500],
              ),
              SizedBox(height: 30),

              CustomIconTextField(
                textEditingController: TextEditingController(),
                textHint: "Enter Password",
                icon: AppAssets.lock,
                isPassword: true,
              ),
              SizedBox(height: 16),
              CustomIconTextField(
                textEditingController: TextEditingController(),
                textHint: "Confirm Password",
                icon: AppAssets.lock,
                isPassword: true,
              ),

              SizedBox(height: 50),
              Button(
                onPressed: () {
                  nextScreen(context, CompanyProfilePage());
                },
                text: "Confirm & Proceed",
                block: true,
                color: AppColor.buttonColor,
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
