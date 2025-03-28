import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/app_dropdown.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/utils/validators.dart';
import 'package:provider/provider.dart';

class CreateOrEditJobFields extends StatefulWidget {
  final bool isEdit;
  const CreateOrEditJobFields({super.key, this.isEdit = false});

  @override
  State<CreateOrEditJobFields> createState() => _CreateOrEditJobFieldsState();
}

class _CreateOrEditJobFieldsState extends State<CreateOrEditJobFields> {
  final FocusNode _jobTitleFocus = FocusNode();

  final FocusNode _locationFocus = FocusNode();

  final FocusNode _qualificationsFocus = FocusNode();

  final FocusNode _jobSalaryMinFocus = FocusNode();

  final FocusNode _jobSalaryMaxFocus = FocusNode();

  final FocusNode _jobSalaryPeriodFocus = FocusNode();

  final FocusNode _jobWorkTypeFocus = FocusNode();

  final FocusNode _jobEmploymentTypeFocus = FocusNode();

  final FocusNode _jobSeniorityFocus = FocusNode();

  final FocusNode _jobSummaryFocus = FocusNode();

  final FocusNode _jobClosingStatementFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _jobTitleFocus.dispose();
    _locationFocus.dispose();
    _qualificationsFocus.dispose();
    _jobSalaryMinFocus.dispose();
    _jobSalaryMaxFocus.dispose();
    _jobSalaryPeriodFocus.dispose();
    _jobWorkTypeFocus.dispose();
    _jobEmploymentTypeFocus.dispose();
    _jobSeniorityFocus.dispose();
    _jobSummaryFocus.dispose();
    _jobClosingStatementFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<JobProvider>();

    return Form(
      key: provider.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconTextField(
            textEditingController: provider.jobTitleController,
            textHint: "Job Title",
            icon: AppAssets.briefcase,
            focusNode: _jobTitleFocus,
            validate: (value) {
              return Validator.validateIsNotEmpty(value);
            },
          ),
          SizedBox(height: 16),

          if (widget.isEdit) ...[
            CustomIconTextField(
              textEditingController: provider.jobSummaryController,
              textHint: "Summary",
              icon: AppAssets.graduation,
              focusNode: _jobSummaryFocus,
              validate: (value) {
                return Validator.validateIsNotEmpty(value);
              },
              // minLines: 2,
              // maxLines: 5,
            ),
            SizedBox(height: 16),

            CustomIconTextField(
              textEditingController: provider.jobClosingStatementController,
              textHint: "Closing Statement",
              icon: AppAssets.graduation,
              focusNode: _jobClosingStatementFocus,
            ),
            SizedBox(height: 16),
          ],

          CustomGoogleLabelInputText(
            hintText: "Location",
            keyboardType: TextInputType.text,
            inputAction: TextInputAction.next,
            controller: provider.jobAddressController,
            icon: AppAssets.location3,
            apiKey: dotenv.env['GOOGLE_API_KEY'] ?? "",
            focusNode: _locationFocus,
            getPlaceDetailWithLatLng: (prediction) {
              provider.jobLocationController.text =
                  "${prediction.lng},${prediction.lat}";
              provider.jobAddressController.text = prediction.description ?? "";
              provider
                  .jobAddressController
                  .selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description?.length ?? 0),
              );
            },
            itemClick: (prediction) {
              provider.jobLocationController.text =
                  "${prediction.lng},${prediction.lat}";
              provider.jobAddressController.text = prediction.description ?? "";
              provider
                  .jobAddressController
                  .selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description?.length ?? 0),
              );
            },
            validate: (value) {
              return Validator.validateIsNotEmpty(value);
            },
          ),
          SizedBox(height: 16),

          if (!widget.isEdit) ...[
            CustomIconTextField(
              textEditingController: provider.jobQualificationsController,
              textHint: "Qualification need for the job",
              icon: AppAssets.graduation,
              focusNode: _qualificationsFocus,
              validate: (value) {
                return Validator.validateIsNotEmpty(value);
              },
              // minLines: 2,
              // maxLines: 5,
            ),
            SizedBox(height: 16),
          ],
          CustomIconTextField(
            textEditingController: provider.jobSalaryMinController,
            keyboardType: TextInputType.number,
            textHint: "Salary Min in USD",
            icon: AppAssets.dollars,
            // iconColor: AppColors.lightBlack.withOpacity(0.5),
            focusNode: _jobSalaryMinFocus,
            validate: (value) {
              return Validator.validateIsNotEmpty(value);
            },
            //icon: AppAssets.money,
          ),
          SizedBox(height: 16),
          CustomIconTextField(
            textEditingController: provider.jobSalaryMaxController,
            keyboardType: TextInputType.number,
            textHint: "Salary Max in USD",
            icon: AppAssets.dollars,
            // iconColor: AppColors.lightBlack.withOpacity(0.5),
            focusNode: _jobSalaryMaxFocus,
            validate: (value) {
              return Validator.validateIsNotEmpty(value);
            },
            //icon: AppAssets.money,
          ),
          // SizedBox(height: 16),
          // CustomIconTextField(
          //   textEditingController: provider.jobSalaryCurrencyController,
          //   textHint: "Salary Currency in USD",
          //   //icon: AppAssets.money,
          // ),
          SizedBox(height: 16),

          AppDropdown(
            isInputField: true,
            label: "Salary Period",
            icon: AppAssets.time,
            iconColor: AppColors.lightBlack.withOpacity(0.5),
            items: provider.jobSalaryPeriods,
            selectedItem: provider.jobSalaryPeriodController.text,
            onChanged: (value) {
              provider.jobSalaryPeriodController.text = value ?? "";
            },
            focusNode: _jobSalaryPeriodFocus,
          ),

          SizedBox(height: 16),

          AppDropdown(
            isInputField: true,
            label: "Work Type",
            icon: AppAssets.location,
            items: provider.jobWorkTypes,
            iconColor: AppColors.lightBlack.withOpacity(0.5),
            selectedItem: provider.jobWorkTypeController.text,
            onChanged: (value) {
              provider.jobWorkTypeController.text = value ?? "";
            },
            focusNode: _jobWorkTypeFocus,
          ),
          SizedBox(height: 16),

          AppDropdown(
            isInputField: true,
            icon: AppAssets.time,
            label: "Employment Type",
            iconColor: AppColors.lightBlack.withOpacity(0.5),
            items: provider.jobEmploymentTypes,
            selectedItem: provider.jobEmploymentTypeController.text,
            onChanged: (value) {
              provider.jobEmploymentTypeController.text = value ?? "";
            },
            focusNode: _jobEmploymentTypeFocus,
          ),

          SizedBox(height: 16),

          AppDropdown(
            isInputField: true,
            icon: AppAssets.briefcase,
            label: "Seniority",
            // iconColor: AppColors.lightBlack.withOpacity(0.5),
            items: provider.jobSeniorities,
            selectedItem: provider.jobSeniorityController.text,
            onChanged: (value) {
              provider.jobSeniorityController.text = value ?? "";
            },
            focusNode: _jobSeniorityFocus,
          ),
        ],
      ),
    );
  }
}
