import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/service/navigation_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? rightChild;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? arrowColor;
  final bool? canNotGoBack;
  const CustomAppBar({
    super.key,
    required this.title,
    this.rightChild,
    this.fontSize,
    this.fontWeight,
    this.arrowColor, this.canNotGoBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if(canNotGoBack == null || canNotGoBack == false) {
                  Navigator.pop(context);
                }
              },
              // child: Icon(Icons.arrow_back, color: AppColor.arrowColor),
              child: SvgPicture.asset(AppAssets.backArrow, color: arrowColor),
            ),
            SizedBox(width: 20),

            Expanded(
              child: CustomRobotoText(
                text: title,
                textSize: fontSize ?? 28,
                fontWeight: fontWeight ?? FontWeight.w400,
              ),
            ),
            if (rightChild != null) ...[const SizedBox(width: 10), rightChild!],
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
