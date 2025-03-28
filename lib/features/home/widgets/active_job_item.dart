// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/features/home/enums/enums.dart';
import 'package:looking2hire/features/home/models/job.dart';
import 'package:looking2hire/features/home/models/saved_jobs.dart';
import 'package:looking2hire/features/home/models/viewed_jobs.dart';
import 'package:looking2hire/utils/date_formart.dart';
import 'package:looking2hire/utils/date_utils.dart';

import '../models/nfc_employer_jobs.dart' as NFCJobs;

class ActiveJobItem extends StatelessWidget {
  // final String title;
  // final String desc;
  // final String date;
  // final String time;
  final Job job;
  final JobStatus? status;
  final VoidCallback? onPressed;
  const ActiveJobItem({
    super.key,
    required this.job,
    // required this.title,
    // required this.desc,
    // required this.date,
    // required this.time,
    this.status,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.greyishWhite,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              job.job_title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.blackOnSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              job.job_address,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.darkGrey2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (status != null) ...[
              const SizedBox(height: 8),

              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Status:",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    status == JobStatus.ended ? "Closed" : "Active",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          status == JobStatus.ended
                              ? AppColors.statusRed
                              : AppColors.statusGreen,
                    ),
                  ),

                  // CircleAvatar(
                  //   radius: 6,
                  //   backgroundColor:
                  //       status == JobStatus.ended
                  //           ? AppColors.statusRed
                  //           : AppColors.statusGreen,
                  // ),
                ],
              ),
            ],
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${job.createdAt.formatDateToReadable()} • ${job.createdAt.toTimeAgo}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGrey2,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(AppAssets.arrowRight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NFCActiveJobItem extends StatelessWidget {
  final NFCJobs.Job job;
  final JobStatus? status;
  final VoidCallback? onPressed;
  const NFCActiveJobItem({
    super.key,
    required this.job,
    this.status,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.greyishWhite,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              job.jobTitle ?? "",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.blackOnSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              job.jobAddress ?? '',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.darkGrey2,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (status != null) ...[
              const SizedBox(height: 8),

              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Status:",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGrey2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    status == JobStatus.ended ? "Closed" : "Active",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          status == JobStatus.ended
                              ? AppColors.statusRed
                              : AppColors.statusGreen,
                    ),
                  ),

                  // CircleAvatar(
                  //   radius: 6,
                  //   backgroundColor:
                  //       status == JobStatus.ended
                  //           ? AppColors.statusRed
                  //           : AppColors.statusGreen,
                  // ),
                ],
              ),
            ],
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${formatDateString2(job.createdAt.toString())} • ${formatDateString2(job.createdAt.toString())}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGrey2,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(AppAssets.arrowRight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SavedJobItem extends StatelessWidget {
  // final String title;
  // final String desc;
  // final String date;
  // final String time;
  final SavedJob job;

  final VoidCallback? onPressed;
  const SavedJobItem({super.key, required this.job, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.greyishWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            CustomRobotoText(
              text: job.jobId?.jobTitle ?? "",
              textSize: 20,
              fontWeight: FontWeight.w600,
              textColor: AppColors.blackOnSurface,
            ),

            const SizedBox(height: 8),
            CustomRobotoText(
              text: job.jobId?.jobAddress ?? "",
              textSize: 13,
              fontWeight: FontWeight.w400,
              textColor: AppColors.darkGrey2,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // if (status != null) ...[
            //   const SizedBox(height: 8),

            //   Row(
            //     children: [
            //       Flexible(
            //         child: Text(
            //           "Status:",
            //           style: const TextStyle(
            //             fontSize: 14,
            //             fontWeight: FontWeight.w400,
            //             color: AppColors.darkGrey2,
            //           ),
            //         ),
            //       ),
            //       const SizedBox(width: 8),
            //       Text(
            //         status == JobStatus.ended ? "Closed" : "Active",
            //         style: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500,
            //           color:
            //               status == JobStatus.ended
            //                   ? AppColors.statusRed
            //                   : AppColors.statusGreen,
            //         ),
            //       ),

            //       // CircleAvatar(
            //       //   radius: 6,
            //       //   backgroundColor:
            //       //       status == JobStatus.ended
            //       //           ? AppColors.statusRed
            //       //           : AppColors.statusGreen,
            //       // ),
            //     ],
            //   ),
            // ],
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    formatDateString2(job.createdAt?.toString() ?? ""),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGrey2,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(AppAssets.arrowRight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ViewedJobItem extends StatelessWidget {
  // final String title;
  // final String desc;
  // final String date;
  // final String time;
  final ViewedJob job;

  final VoidCallback? onPressed;
  const ViewedJobItem({super.key, required this.job, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.greyishWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            CustomText(
              text: job.jobId?.jobTitle ?? "",
              textSize: 20,
              fontWeight: FontWeight.w600,
              textColor: AppColors.blackOnSurface,
            ),

            const SizedBox(height: 8),
            CustomText(
              text: job.jobId?.jobAddress ?? "",
              textSize: 13,
              fontWeight: FontWeight.w400,
              textColor: AppColors.darkGrey2,
            ),

            // if (status != null) ...[
            //   const SizedBox(height: 8),

            //   Row(
            //     children: [
            //       Flexible(
            //         child: Text(
            //           "Status:",
            //           style: const TextStyle(
            //             fontSize: 14,
            //             fontWeight: FontWeight.w400,
            //             color: AppColors.darkGrey2,
            //           ),
            //         ),
            //       ),
            //       const SizedBox(width: 8),
            //       Text(
            //         status == JobStatus.ended ? "Closed" : "Active",
            //         style: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500,
            //           color:
            //               status == JobStatus.ended
            //                   ? AppColors.statusRed
            //                   : AppColors.statusGreen,
            //         ),
            //       ),

            //       // CircleAvatar(
            //       //   radius: 6,
            //       //   backgroundColor:
            //       //       status == JobStatus.ended
            //       //           ? AppColors.statusRed
            //       //           : AppColors.statusGreen,
            //       // ),
            //     ],
            //   ),
            // ],
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Text(
                    formatDateString2(job.createdAt?.toString() ?? ""),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGrey2,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(AppAssets.arrowRight),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
