import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/constants/app_assets.dart';

class CustomPopup extends StatelessWidget {
  final Widget? child;
  final List<String> options;
  final List<String> logos;
  final void Function(String value)? onSelected;
  const CustomPopup({
    super.key,
    this.child,
    required this.options,
    required this.logos,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      offset: Offset(0, 15),
      onSelected: onSelected,
      itemBuilder: (context) {
        return List.generate(options.length, (index) {
          final option = options[index];
          final logo = index < logos.length ? logos[index] : null;

          return PopupMenuItem(
            value: option,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (logo != null) ...[
                  SvgPicture.asset(logo),
                  const SizedBox(width: 10),
                ],
                Text(
                  option,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lighterBlack,
                  ),
                ),
              ],
            ),
          );
        });
      },
      child: child ?? SvgPicture.asset(AppAssets.more),
    );
  }
}
