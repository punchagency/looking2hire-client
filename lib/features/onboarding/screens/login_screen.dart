import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/utils/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Get Hired Now!"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 64),
              CustomRobotoText(
                text: "Welcome Back!",
                textSize: 24,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 15),
              CustomText(
                text: "Find your next job with ease.",
                textSize: 16,
                fontWeight: FontWeight.w400,
                textColor: AppColor.grey[500],
              ),
              CustomLabelInputText(
                keyboardType: TextInputType.text,
                inputAction: TextInputAction.next,
                label: "",
                placeholder: "LinkedIn Button",
              ),
              SizedBox(height: 15),
              CustomLabelInputText(
                keyboardType: TextInputType.text,
                inputAction: TextInputAction.next,
                label: "",
                placeholder: "Google Button",
              ),
              SizedBox(height: 50),
              Button(
                onPressed: () {},
                text: "Scan",
                textSize: 18,
                block: true,
                color: AppColor.buttonColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
