import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/constants/app_colors.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/features/home/widgets/job_detail_item.dart';
import 'package:looking2hire/features/home/widgets/job_logo.dart';

class JobCard extends StatelessWidget {
  final String logoUrl;
  final String price;
  final String title;
  final String location;
  final bool isFullTime;
  final bool isRemote;
  final bool isSenior;
  final Color bgColor;
  final VoidCallback onPressed;
  const JobCard({
    super.key,
    required this.logoUrl,
    required this.price,
    required this.title,
    required this.location,
    required this.isFullTime,
    required this.isRemote,
    required this.isSenior,
    required this.onPressed,
    required this.bgColor,
  });

  bool get isWhite => bgColor == Colors.white;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.only(right: 4, bottom: 10),
        child: SizedBox(
          width: 280,
          child: Card(
            color: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.all(12),
              // decoration: BoxDecoration(
              //   color: bgColor,
              //   borderRadius: BorderRadius.circular(12),
              //   boxShadow: [
              //     BoxShadow(
              //       offset: Offset(0, 5.87),
              //       color: Color(0xFF3E4F88).withOpacity(0.2),
              //       blurRadius: 17.6,
              //     ),
              //   ],
              // ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JobLogo(logoUrl: logoUrl),
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: !isWhite ? Colors.white : AppColors.grey1,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: !isWhite ? Colors.white : AppColors.grey3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            height: 20,
                            child: Row(
                              children: [
                                if (isFullTime)
                                  JobDetailItem(
                                    title: "Full Time",
                                    hasBorder: true,
                                  ),
                                if (isRemote)
                                  JobDetailItem(
                                    title: "Remote",
                                    hasBorder: true,
                                  ),
                                if (isSenior)
                                  JobDetailItem(
                                    title: "Senior",
                                    hasBorder: true,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SvgPicture.asset(AppAssets.save),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
