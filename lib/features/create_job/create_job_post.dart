import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_app_bar.dart';
import 'package:looking2hire/components/custom_label_text_form_field.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/extensions/context_extensions.dart';
import 'package:looking2hire/features/create_decal/decal_step1_screen.dart';
import 'package:looking2hire/features/home/providers/job_provider.dart';
import 'package:looking2hire/utils/button.dart';
import 'package:looking2hire/utils/custom_snackbar.dart';
import 'package:looking2hire/utils/next_screen.dart';
import 'package:provider/provider.dart';

import '../home/pages/hire_job_post_details_page.dart';

class CreateJobPost extends StatefulWidget {
  const CreateJobPost({super.key});

  @override
  State<CreateJobPost> createState() => _CreateJobPostState();
}

class _CreateJobPostState extends State<CreateJobPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Looking To Hire",
        arrowColor: AppColor.black,
      ),
      body: Consumer<JobProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48),
                CustomRobotoText(
                  text: "Create Job Post",
                  textSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                CustomRobotoText(
                  text:
                      "Provide job details to attract the right candidates and start hiring today.",
                  textSize: 16,
                  fontWeight: FontWeight.w400,
                  textColor: AppColor.grey[500],
                ),
                SizedBox(height: 32),
                CustomIconTextField(
                  textEditingController: provider.jobTitleController,
                  textHint: "Job Title",
                  icon: AppAssets.briefcase,
                ),
                SizedBox(height: 16),
                GooglePlacesAutoCompleteTextFormField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: "Location",
                    hintStyle: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.black45),
                    fillColor: AppColor.grey[100]?.withOpacity(.05),

                    border: OutlineInputBorder(
                      // borderSide: BorderSide.none,
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: .9,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      // borderSide: BorderSide.none,
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: .9,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // borderSide: BorderSide.none,
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: .9,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 2.h,
                      horizontal: 5.w,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        AppAssets.location3,
                        height: 17,
                        width: 17,
                      ),
                    ),
                  ),

                  textEditingController: provider.jobAddressController,
                  googleAPIKey: dotenv.env['GOOGLE_API_KEY'] ?? "",

                  debounceTime: 400, // defaults to 600 ms
                  // countries: [
                  //   "de",
                  // ], // optional, by default the list is empty (no restrictions)
                  fetchCoordinates:
                      true, // if you require the coordinates from the place details
                  onPlaceDetailsWithCoordinatesReceived: (prediction) {
                    // this method will return latlng with place detail
                    provider.jobLocationController.text =
                        "${prediction.lat},${prediction.lng}";
                    print("Coordinates: (${prediction.lat},${prediction.lng})");
                  }, // this callback is called when fetchCoordinates is true
                  onSuggestionClicked: (prediction) {
                    provider.jobAddressController.text =
                        prediction.description ?? "";
                    provider
                        .jobAddressController
                        .selection = TextSelection.fromPosition(
                      TextPosition(offset: prediction.description?.length ?? 0),
                    );
                  },
                ),
                // CustomIconTextField(
                //   textEditingController: provider.jobLocationController,
                //   textHint: "Location",
                //   icon: AppAssets.location3,
                // ),
                CustomGoogleLabelInputText(
                  label: "Location",
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  controller: provider.jobAddressController,
                  apiKey: dotenv.env['GOOGLE_API_KEY'] ?? "",
                  getPlaceDetailWithLatLng: (prediction) {
                    provider.jobLocationController.text =
                        "${prediction.lat},${prediction.lng}";
                    print("Coordinates: (${prediction.lat},${prediction.lng})");
                  },
                  itemClick: (prediction) {
                    provider.jobLocationController.text =
                        "${prediction.lat},${prediction.lng}";
                    print("Coordinates: (${prediction.lat},${prediction.lng})");
                  },

                  // style: Theme.of(context).textTheme.bodyMedium,
                  // decoration: InputDecoration(
                  //   hintText: "Location",
                  //   hintStyle: Theme.of(
                  //     context,
                  //   ).textTheme.bodyMedium?.copyWith(color: Colors.black45),
                  //   fillColor: AppColor.grey[100]?.withOpacity(.05),

                  //   border: OutlineInputBorder(
                  //     // borderSide: BorderSide.none,
                  //     borderSide: BorderSide(
                  //       color: Colors.grey.shade300,
                  //       width: .9,
                  //     ),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   enabledBorder: OutlineInputBorder(
                  //     // borderSide: BorderSide.none,
                  //     borderSide: BorderSide(
                  //       color: Colors.grey.shade300,
                  //       width: .9,
                  //     ),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   focusedBorder: OutlineInputBorder(
                  //     // borderSide: BorderSide.none,
                  //     borderSide: BorderSide(
                  //       color: Colors.grey.shade300,
                  //       width: .9,
                  //     ),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   contentPadding: EdgeInsets.symmetric(
                  //     vertical: 2.h,
                  //     horizontal: 5.w,
                  //   ),
                  //   prefixIcon: Padding(
                  //     padding: const EdgeInsets.all(12.0),
                  //     child: SvgPicture.asset(
                  //       AppAssets.location3,
                  //       height: 17,
                  //       width: 17,
                  //     ),
                  //   ),
                  // ),
                ),
                SizedBox(height: 16),
                CustomIconTextField(
                  textEditingController: provider.jobQualificationsController,
                  textHint: "Qualification need for the job",
                  icon: AppAssets.graduation,
                ),
                SizedBox(height: 40),
                Button(
                  onPressed: () {
                    provider.createJob().then((job) {
                      if (job != null) {
                        setSnackBar(
                          context: context,
                          title: "Success",
                          message: provider.successMessage,
                        );
                        context.pushReplacement(
                          HireJobPostDetailsPage(job: job),
                        );
                      } else {
                        setSnackBar(
                          context: context,
                          title: "Error",
                          message: provider.errorMessage,
                        );
                      }
                    });

                    // nextScreen(context, DecalStep1Screen());
                  },
                  text: "Generate Job",
                  block: true,
                  color: AppColor.buttonColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
