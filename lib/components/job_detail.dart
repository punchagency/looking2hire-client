import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';

class JobDetail extends StatelessWidget {
  final String title;
  final String value;
  const JobDetail({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlack,
              ),
            ),
            TextSpan(
              text: ": $value",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.lightBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
