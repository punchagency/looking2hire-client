import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';

class JobDetailItem extends StatelessWidget {
  final String title;
  final bool hasBorder;
  const JobDetailItem({
    super.key,
    required this.title,
    required this.hasBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border:
            hasBorder
                ? Border.all(width: 0.6, color: Colors.black.withOpacity(0.13))
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
