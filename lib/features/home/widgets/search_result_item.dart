import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/features/home/models/job.dart';

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
      child: SizedBox(
        height: 20,
        child: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: "${job.company} ",
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.lightBlack,
            ),
            children: [
              TextSpan(
                text: job.desc,

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
