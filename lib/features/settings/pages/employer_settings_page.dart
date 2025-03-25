import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/title_information.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/onboarding/provider/auth_provider.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/validators.dart';
import 'package:provider/provider.dart';

class EmployerSettingsPage extends StatefulWidget {
  const EmployerSettingsPage({super.key});

  @override
  State<EmployerSettingsPage> createState() => _EmployerSettingsPageState();
}

class _EmployerSettingsPageState extends State<EmployerSettingsPage> {
  void saveChanges() {
    print("saveChanges");
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: CustomAppBar(title: "Settings"),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 32),
          TitleInformation(
            title: "Employer Settings",
            hint: "Customize your account settings seamlessly",
          ),
          const SizedBox(height: 32),
          // CustomRobotoText(
          //   text: "Create Employer Account",
          //   textSize: 24,
          //   fontWeight: FontWeight.w600,
          // ),
          // // SizedBox(height: 15),
          // CustomText(
          //   text: "Your profile creation takes just seconds with AI",
          //   textSize: 16,
          //   fontWeight: FontWeight.w400,
          //   textColor: AppColor.grey[500],
          // ),
          SizedBox(height: 30),
          CustomIconTextField(
            textEditingController: provider.companyNameController,
            textHint: "Business Name",
            icon: AppAssets.business,
            keyboardType: TextInputType.text,
            inputAction: TextInputAction.next,
            minLines: 1,

            validate: (value) {
              return Validator.validateIsNotEmpty(value);
            },
          ),

          SizedBox(height: 16),
          CustomIconTextField(
            textEditingController: provider.fullNameController,
            textHint: "Hiring Contact Full Name",
            icon: AppAssets.user,
            validate: (value) {
              return Validator.validateIsNotEmpty(value);
            },
            keyboardType: TextInputType.text,
            inputAction: TextInputAction.next,
            minLines: 1,
          ),
          SizedBox(height: 16),
          CustomIconTextField(
            textEditingController: provider.emailController,
            textHint: "Hiring Contact Email",
            icon: AppAssets.mail,
            validate: (value) {
              return Validator.validateIsNotEmpty(value);
            },
            keyboardType: TextInputType.emailAddress,
            inputAction: TextInputAction.next,
            minLines: 1,
          ),
          SizedBox(height: 16),
          CustomIconTextField(
            textEditingController: provider.phoneController,
            textHint: "Hiring Contact Phone",
            icon: AppAssets.phone,
            validate: (value) {
              return Validator.validateIsNotEmpty(value);
            },
            keyboardType: TextInputType.number,
            inputAction: TextInputAction.next,
            minLines: 1,
          ),
          SizedBox(height: 40),
          Button(
            onPressed: saveChanges,
            text: "Save Changes",
            block: true,
            color: AppColor.buttonColor,
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
