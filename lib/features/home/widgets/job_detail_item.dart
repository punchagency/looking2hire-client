import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';

class JobDetailItem extends StatelessWidget {
  final String title;
  final bool hasBorder;
  const JobDetailItem(
      {super.key, required this.title, required this.hasBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: hasBorder
            ? Border.all(
                width: 0.6,
                color: AppColors.lightBlack.withValues(alpha: 0.8),
              )
            : null,
        boxShadow: hasBorder
            ? [
                BoxShadow(
                  offset: Offset(0, 0),
                  color: Colors.black.withValues(alpha: 0.13),
                  blurRadius: 3.1,
                ),
              ]
            : null,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.lightBlack,
        ),
      ),
    );
  }
}
