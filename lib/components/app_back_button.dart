import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/constants/app_assets.dart';

class AppBackButton extends StatelessWidget {
  final Color? arrowColor;
  const AppBackButton({super.key, this.arrowColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      // child: Icon(Icons.arrow_back, color: AppColor.arrowColor),
      icon: SvgPicture.asset(AppAssets.backArrow, color: arrowColor),
    );
  }
}
