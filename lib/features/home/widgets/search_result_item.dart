import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/features/home/models/job.dart';
import 'package:looking2hire/features/home/models/job_2.dart';

class SearchResultItem extends StatelessWidget {
  final Job job;
  final VoidCallback onPressed;
  const SearchResultItem({
    super.key,
    required this.job,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        alignment: Alignment.centerLeft,
        child: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: "${job.job_title} ",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.lightBlack,
            ),
            children: [
              TextSpan(
                text: job.summary,
                style: const TextStyle(
                  color: AppColors.lightBlack,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
