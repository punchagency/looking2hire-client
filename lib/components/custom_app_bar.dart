import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? rightChild;
  final Widget? titleChild;
  final double fontSize;
  final FontWeight fontWeight;
  final Color arrowColor;
  final Color titleColor;
  final bool centeredTitle;
  final bool needsDrawer;
  final bool canNotGoBack;
  final VoidCallback? onBackPressed;
  const CustomAppBar({
    super.key,
    required this.title,
    this.titleChild,
    this.rightChild,
    this.fontSize = 24,
    this.fontWeight = FontWeight.w600,
    this.arrowColor = AppColors.lightBlack,
    this.titleColor = AppColors.lightBlack,
    this.needsDrawer = false,
    this.canNotGoBack = false,
    this.centeredTitle = true,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    void showDrawer() {
      Scaffold.of(context).openEndDrawer();
    }

    if (centeredTitle) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: SizedBox(
            height: 50,
            child: Stack(
              children: [
                if (!canNotGoBack)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        onPressed:
                            onBackPressed ??
                            () {
                              Navigator.pop(context);
                            },
                        // child: Icon(Icons.arrow_back, color: AppColor.arrowColor),
                        icon: SvgPicture.asset(
                          AppAssets.backArrow,
                          colorFilter: ColorFilter.mode(
                            arrowColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(width: 20),

                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 30,
                  right: 30,
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomRobotoText(
                      text: title,
                      textSize: fontSize,
                      fontWeight: fontWeight,
                      textColor: titleColor,
                      alignText: centeredTitle ? TextAlign.center : null,
                    ),
                  ),
                ),
                if (rightChild != null || needsDrawer)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(width: 10),
                          needsDrawer
                              ? IconButton(
                                icon: SvgPicture.asset(AppAssets.menu),
                                onPressed: showDrawer,
                              )
                              : rightChild!,
                        ],
                      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          children: [
            if (!canNotGoBack)
              IconButton(
                onPressed:
                    onBackPressed ??
                    () {
                      Navigator.pop(context);
                    },
                // child: Icon(Icons.arrow_back, color: AppColor.arrowColor),
                icon: SvgPicture.asset(
                  AppAssets.backArrow,
                  colorFilter: ColorFilter.mode(arrowColor, BlendMode.srcIn),
                ),
              ),
            SizedBox(width: 10),

            Expanded(
              child: CustomRobotoText(
                text: title,
                textSize: fontSize,
                fontWeight: fontWeight,
                textColor: titleColor,
              ),
            ),
            if (rightChild != null || needsDrawer) ...[
              const SizedBox(width: 10),
              needsDrawer
                  ? IconButton(
                    icon: SvgPicture.asset(AppAssets.menu),
                    onPressed: showDrawer,
                  )
                  : rightChild!,
            ],
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}
