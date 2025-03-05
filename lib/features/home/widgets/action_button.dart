// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final double radius;
  final EdgeInsets? padding;
  final Color? color;
  final Color? textColor;

  final bool useShadow;
  const ActionButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.height = 55,
    this.radius = 12,
    this.padding,
    this.color,
    this.textColor,
    this.useShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        height: height,
        alignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? AppColors.blue,
          borderRadius: BorderRadius.circular(radius),
          boxShadow:
              useShadow
                  ? [
                    BoxShadow(
                      offset: Offset(0, 5.89),
                      color:
                          color?.withOpacity(0.2) ??
                          AppColors.blue.withOpacity(0.2),
                      blurRadius: 17.66,
                    ),
                  ]
                  : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
