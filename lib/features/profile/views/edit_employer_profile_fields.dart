import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:looking2hire/components/action_button_with_icon.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/rounded_image.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/features/home/models/job.dart';
import 'package:looking2hire/features/profile/provider/user_provider.dart';
import 'package:provider/provider.dart';

class EditEmployerProfileFields extends StatefulWidget {
  const EditEmployerProfileFields({super.key});

  @override
  State<EditEmployerProfileFields> createState() =>
      _EditEmployerProfileFieldsState();
}

class _EditEmployerProfileFieldsState extends State<EditEmployerProfileFields> {
  //String _imagePath = "";
  void selectImage() async {
    final userProvider = context.read<UserProvider>();

    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      //_imagePath = image.path;
      userProvider.companyLogoController.text = image.path;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    userProvider.companyNameController.text =
        userProvider.employer.company_name ?? "";
    userProvider.headingController.text = userProvider.employer.heading ?? "";
    //userProvider.emailController.text = userProvider.employer.email ?? "";
    userProvider.bodyController.text = userProvider.employer.body ?? "";
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RoundedImage(
              imageUrl:
                  userProvider.companyLogoController.text.isNotEmpty
                      ? userProvider.companyLogoController.text
                      : userProvider.employer.company_logo,
              width: 60,
              height: 60,
              isFileImage: userProvider.companyLogoController.text.isNotEmpty,
            ),
            const SizedBox(width: 10),
            ActionButtonWithIcon(title: "Add Logo", onPressed: selectImage),
          ],
        ),
        SizedBox(height: 16),
        CustomIconTextField(
          textEditingController: userProvider.companyNameController,
          textHint: "Company Name",
          icon: AppAssets.user,
        ),
        // SizedBox(height: 16),
        // CustomIconTextField(
        //   textEditingController: userProvider.headingController,
        //   textHint: "Email",
        //   icon: AppAssets.briefcase,
        // ),
        SizedBox(height: 16),
        CustomIconTextField(
          textEditingController: userProvider.headingController,
          textHint: "Heading",
          icon: AppAssets.description,
        ),
        SizedBox(height: 16),
        CustomIconTextField(
          textEditingController: userProvider.bodyController,
          textHint: "Body",
          icon: AppAssets.description,
        ),
      ],
    );
  }
}
