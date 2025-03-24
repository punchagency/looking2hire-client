import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/extensions/context_extensions.dart';

class DrawerItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback? onPressed;
  final bool popBefore;
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    this.onPressed,
    this.popBefore = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            if (popBefore) context.pop();
            if (onPressed != null) onPressed!();
          },
          child: SizedBox(
            height: 55,
            child: Row(
              children: [
                const SizedBox(width: 24),
                SvgPicture.asset(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightBlack.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
          color: AppColors.lightBlack.withOpacity(0.1),
        ),
      ],
    );
  }
}
