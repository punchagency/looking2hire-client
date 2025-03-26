import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/dotted_lines_painter.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/datetime_extensions.dart';
import 'package:looking2hire/features/onboarding/models/applicant_signin.dart';

class EmploymentHistoryItem extends StatelessWidget {
  final EmploymentHistory employmentHistory;
  const EmploymentHistoryItem({super.key, required this.employmentHistory});

  @override
  Widget build(BuildContext context) {
    final responsibilities =
        employmentHistory.description != null
            ? [employmentHistory.description!]
            : [];
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
                  "${employmentHistory.jobTitle} | ${employmentHistory.companyName}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightBlack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${employmentHistory.startDate?.toMonthYear() ?? "Present"} - ${employmentHistory.endDate?.toMonthYear() ?? "Present"}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.darkGrey2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  employmentHistory.description ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.lighterBlack,
                  ),
                ),
                // if (responsibilities != null)
                // Column(
                //   mainAxisSize: MainAxisSize.min,
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: List.generate(responsibilities!.length, (index) {
                //     final responsibility = responsibilities![index];
                //     return Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(top: 8.0, left: 8),
                //           child: CircleAvatar(
                //             radius: 2,
                //             backgroundColor: AppColors.lighterBlack,
                //           ),
                //         ),
                //         const SizedBox(width: 8),
                //         Expanded(
                //           child: Text(
                //             responsibility,
                //             style: const TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w400,
                //               color: AppColors.lighterBlack,
                //             ),
                //           ),
                //         ),
                //       ],
                //     );
                //   }),
                // ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
