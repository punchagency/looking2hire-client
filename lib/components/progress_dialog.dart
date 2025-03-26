import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/service/navigation_service.dart';

class ProgressDialog extends StatelessWidget {
  final bool? isSearch;
  final String? message;

  const ProgressDialog({super.key, this.isSearch, this.message});

  @override
  Widget build(BuildContext context) {
    return isSearch == true
        ? Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: LoadingAnimationWidget.discreteCircle(
                  size: 20,
                  color: AppColor.arrowColor,
                  secondRingColor: AppColor.secondaryColor,
                  thirdRingColor: AppColor.accent,
                ),
              ),
              const SizedBox(height: 30),
              CustomRobotoText(
                text: message ?? "Please wait...",
                textColor: Colors.white,
                alignText: TextAlign.center,
              ),
            ],
          ),
        )
        : Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LoadingAnimationWidget.discreteCircle(
                size: 20,
                color: AppColor.primaryColor,
                secondRingColor: AppColor.secondaryColor,
                thirdRingColor: AppColor.accent,
              ),
              if ((message ?? "").isNotEmpty) ...[
                const SizedBox(height: 10),
                CustomRobotoText(
                  text: message!,
                  textColor: Colors.white,
                  alignText: TextAlign.center,
                ),
              ],
            ],
          ),
        );
  }
}

void setProgressDialog({String? message}) => showDialog(
  context: currentContext!,
  barrierDismissible: false,
  builder: (context) {
    return ProgressDialog(message: message);
  },
);
