import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/extensions/datetime_extensions.dart';
import 'package:looking2hire/features/home/models/job_application.dart';
import 'package:looking2hire/reuseable/extensions/string_extensions.dart';

enum ApplicantStatus { shortlisted, interviewed, hired, rejected }

class ApplicantCard extends StatelessWidget {
  // final String name;
  // final String image;
  // final String experience;
  // final String date;
  // final ApplicantStatus status;
  final JobApplication jobApplication;
  final VoidCallback? onPressed;

  const ApplicantCard({
    super.key,
    // required this.image,
    // required this.name,
    // required this.experience,
    // required this.date,
    // required this.status,
    required this.jobApplication,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final applicant = jobApplication.applicant;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image:
                    (applicant?.profilePic ?? "").isEmpty
                        ? null
                        : DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            applicant!.profilePic!,
                          ),
                        ),
                // image: DecorationImage(image: AssetImage(image)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    applicant?.name ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlack,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    applicant?.heading ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  Text(
                    "${jobApplication.status?.capitalize} candidates\n${jobApplication.createdAt.toDateTime.toMonthDayYear()}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
