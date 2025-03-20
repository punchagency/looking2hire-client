import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:looking2hire/constants/app_color.dart';

class AppProgressBar extends StatelessWidget {
  const AppProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.discreteCircle(
      size: 20,
      color: AppColor.arrowColor,
      secondRingColor: AppColor.secondaryColor,
      thirdRingColor: AppColor.accent,
    );
  }
}
