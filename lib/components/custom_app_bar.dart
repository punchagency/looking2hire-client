import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';
import 'package:looking2hire/service/navigation_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? rightChild;
  final Widget? titleChild;

  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? arrowColor;
  final Color? titleColor;
  final bool centeredTitle;

  final bool? canNotGoBack;
  const CustomAppBar({
    super.key,
    required this.title,
    this.titleChild,
    this.rightChild,
    this.fontSize,
    this.fontWeight,
    this.arrowColor,
    this.titleColor,
    this.canNotGoBack,
    this.centeredTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    if (centeredTitle) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: SizedBox(
            height: 50,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      if (canNotGoBack == null || canNotGoBack == false) {
                        Navigator.pop(context);
                      }
                    },
                    // child: Icon(Icons.arrow_back, color: AppColor.arrowColor),
                    child: SvgPicture.asset(
                      AppAssets.backArrow,
                      color: arrowColor,
                    ),
                  ),
                ),
                SizedBox(width: 20),

                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 50,
                  right: 50,
                  child: CustomRobotoText(
                    text: title,
                    textSize: fontSize ?? 28,
                    fontWeight: fontWeight ?? FontWeight.w400,
                    textColor: titleColor,
                    alignText: centeredTitle ? TextAlign.center : null,
                  ),
                ),
                if (rightChild != null)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [const SizedBox(width: 10), rightChild!],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if (canNotGoBack == null || canNotGoBack == false) {
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
                textColor: titleColor,
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
