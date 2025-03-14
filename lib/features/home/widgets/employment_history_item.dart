import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/dotted_lines_painter.dart';
import 'package:looking2hire/constants/app_assets.dart';

class EmploymentHistoryItem extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String startDate;
  final String endDate;
  final List<String>? responsibilities;
  const EmploymentHistoryItem({
    super.key,
    required this.companyName,
    required this.jobTitle,
    required this.startDate,
    required this.endDate,
    this.responsibilities,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              SvgPicture.asset(AppAssets.circleDot),
              Expanded(
                child: CustomPaint(
                  painter: DottedLinePainter(
                    color: AppColors.lightBlack.withOpacity(0.3),
                    strokeWidth: 1,
                  ),
                  child: const SizedBox(width: 2),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 4),
                Text(
                  "$jobTitle | $companyName",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$startDate - $endDate",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkGrey2,
                  ),
                ),
                const SizedBox(height: 4),
                if (responsibilities != null)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(responsibilities!.length, (index) {
                      final responsibility = responsibilities![index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 8),
                            child: CircleAvatar(
                              radius: 2,
                              backgroundColor: AppColors.lighterBlack,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              responsibility,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lighterBlack,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
