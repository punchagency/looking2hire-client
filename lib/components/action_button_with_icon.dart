import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';

class ActionButtonWithIcon extends StatelessWidget {
  final String title;
  final String? icon;
  final Color color;
  final Color? iconColor;

  final bool isDestructive;
  final Function()? onPressed;
  const ActionButtonWithIcon({
    super.key,
    required this.title,
    this.icon,
    this.color = const Color(0xFFF5F5F5),
    this.iconColor,
    this.isDestructive = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 40.0,
        decoration: BoxDecoration(
          color: isDestructive ? AppColors.dialogRed : AppColors.lightBlack,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              SvgPicture.asset(icon!, color: iconColor),
              const SizedBox(width: 8),
            ],

            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
