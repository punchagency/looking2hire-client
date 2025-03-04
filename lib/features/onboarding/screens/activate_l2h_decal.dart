import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/utils/button.dart';

class ActivateL2hDecal extends StatefulWidget {
  const ActivateL2hDecal({super.key});

  @override
  State<ActivateL2hDecal> createState() => _ActivateL2hDecalState();
}

class _ActivateL2hDecalState extends State<ActivateL2hDecal> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Hire Candidates Now!", arrowColor: AppColor.arrowColor,),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 64),
              CustomRobotoText(text: "Activate Your L2H Decal", textSize: 24, fontWeight: FontWeight.w600),
              SizedBox(height: 15),
              CustomText(
                text: "Account creation takes just seconds",
                textSize: 16,
                fontWeight: FontWeight.w400,
                textColor: AppColor.grey[500],
              ),
              SizedBox(height: 30),
              CustomLabelInputText(
                keyboardType: TextInputType.text,
                inputAction: TextInputAction.next,
                label: "Business Name",
                placeholder: "Google Maps Lookup",
              ),
              SizedBox(height: 30),
              CustomLabelInputText(
                keyboardType: TextInputType.text,
                inputAction: TextInputAction.next,
                label: "Hiring Contact Full Name",
                placeholder: "John Smith",
              ),
              SizedBox(height: 30),
              CustomLabelInputText(
                keyboardType: TextInputType.text,
                inputAction: TextInputAction.next,
                label: "Hiring Contact Phone",
                placeholder: "Phone Number",
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: AppColor.arrowColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (changed) {
                      isChecked = !isChecked;
                      setState(() {});
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: [
                        TextSpan(text: 'I accepts the Terms '),
                        TextSpan(
                          text: 'Read our T&Cs',
                          style: TextStyle(color: Colors.grey.shade400, decoration: TextDecoration.underline),
                          recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {

                              });
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Button(onPressed: () {}, text: "Create account", block: true, color: AppColor.buttonColor),
            ],
          ),
        ),
      ),
    );
  }
}
