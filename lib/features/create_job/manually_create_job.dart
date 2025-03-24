import 'dart:math';

import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/features/create_job/provider/create_job_provider.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/validators.dart';
import 'package:provider/provider.dart';

class ManuallyCreateJob extends StatefulWidget {
  const ManuallyCreateJob({super.key});

  @override
  State<ManuallyCreateJob> createState() => _ManuallyCreateJobState();
}

class _ManuallyCreateJobState extends State<ManuallyCreateJob> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _employmentTypeController =
      TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyDescController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void dispose() {
    _jobTitleController.dispose();
    _employmentTypeController.dispose();
    _companyNameController.dispose();
    _companyDescController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

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
        } else {
          _endDateController.text = formattedDate;
        }
      });
    }
  }

  void _submitForm() {
    if (formKey.currentState?.validate() ?? false) {
      // Create a job history object and save it
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateJobProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: "Looking To Work",
            arrowColor: AppColor.black,
            centeredTitle: true,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            // needsDrawer: true,
          ),
          // endDrawer: const AppDrawer(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 56),
                const CustomRobotoText(
                  text: "Add Your Job History",
                  textSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 15),
                CustomText(
                  text:
                      "Showcase your experience to attract better job opportunities.",
                  textSize: 16,
                  fontWeight: FontWeight.w400,
                  textColor: AppColor.grey[500]!,
                ),
                const SizedBox(height: 29),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomLabelInputText(
                        controller: _jobTitleController,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "",
                        placeholder: "Job Title",
                        validate: (value) {
                          return Validator.validateIsNotEmpty(value);
                        },
                      ),
                      const SizedBox(height: 18),
                      CustomLabelInputText(
                        controller: _employmentTypeController,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "",
                        placeholder: "Employment Type",
                        validate: (value) {
                          return Validator.validateIsNotEmpty(value);
                        },
                      ),
                      const SizedBox(height: 18),
                      CustomLabelInputText(
                        controller: _companyNameController,
                        keyboardType: TextInputType.text,
                        inputAction: TextInputAction.next,
                        label: "",
                        placeholder: "Company Name",
                        validate: (value) {
                          return Validator.validateIsNotEmpty(value);
                        },
                      ),
                      const SizedBox(height: 18),
                      CustomLabelInputText(
                        controller: _companyDescController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        inputAction: TextInputAction.newline,
                        label: "",
                        placeholder: "Company Description",
                        validate: (value) {
                          return Validator.validateIsNotEmpty(value);
                        },
                      ),
                      const SizedBox(height: 18),
                      CustomLabelInputText(
                        controller: _startDateController,
                        keyboardType: TextInputType.datetime,
                        inputAction: TextInputAction.next,
                        readOnly: true,
                        onTap: () => _selectDate(context, true),
                        label: "",
                        placeholder: "Start Date",
                        validate: (value) {
                          return Validator.validateIsNotEmpty(value);
                        },
                      ),
                      const SizedBox(height: 18),
                      CustomLabelInputText(
                        controller: _endDateController,
                        keyboardType: TextInputType.datetime,
                        inputAction: TextInputAction.done,
                        readOnly: true,
                        onTap: () => _selectDate(context, false),
                        label: "",
                        placeholder: "End Date",
                        validate: (value) {
                          return Validator.validateIsNotEmpty(value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Button(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      provider.createEmploymentHistory(
                        context: context,
                        jobTitle: _jobTitleController.text,
                        companyName: _companyNameController.text,
                        employmentType: _employmentTypeController.text,
                        startDate: _startDateController.text,
                        endDate: _endDateController.text,
                        description: _companyDescController.text,
                      );
                    }
                  },
                  text: "Save",
                  textSize: 18,
                  block: true,
                  color: AppColor.buttonColor,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
    );
  }
}
