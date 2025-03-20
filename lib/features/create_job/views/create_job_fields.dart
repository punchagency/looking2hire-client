import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/features/home/widgets/bullet_formatter.dart';
import 'package:provider/provider.dart';

class CreateJobFields extends StatefulWidget {
  const CreateJobFields({super.key});

  @override
  State<CreateJobFields> createState() => _CreateJobFieldsState();
}

class _CreateJobFieldsState extends State<CreateJobFields> {
  final FocusNode _jobTitleFocus = FocusNode();

  final FocusNode _locationFocus = FocusNode();

  final FocusNode _qualificationsFocus = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _jobTitleFocus.dispose();
    _locationFocus.dispose();
    _qualificationsFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<JobProvider>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomIconTextField(
          textEditingController: provider.jobTitleController,
          textHint: "Job Title",
          icon: AppAssets.briefcase,
          focusNode: _jobTitleFocus,
        ),
        SizedBox(height: 16),

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
                "${prediction.lat},${prediction.lng}";
            provider.jobAddressController.text = prediction.description ?? "";
            provider
                .jobAddressController
                .selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0),
            );
          },
          itemClick: (prediction) {
            provider.jobLocationController.text =
                "${prediction.lat},${prediction.lng}";
            provider.jobAddressController.text = prediction.description ?? "";
            provider
                .jobAddressController
                .selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0),
            );
          },
        ),
        SizedBox(height: 16),
        CustomIconTextField(
          textEditingController: provider.jobQualificationsController,
          textHint: "Qualification need for the job",
          icon: AppAssets.graduation,
          focusNode: _qualificationsFocus,
          minLines: 5,
          maxLines: 10,
          inputFormatters: [BulletFormatter()],
        ),
      ],
    );
  }
}
