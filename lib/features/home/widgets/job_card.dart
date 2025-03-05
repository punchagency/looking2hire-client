import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/app_colors.dart';
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
  final bool selected;
  const JobCard({
    super.key,
    required this.logoUrl,
    required this.price,
    required this.title,
    required this.location,
    required this.isFullTime,
    required this.isRemote,
    required this.isSenior,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        width: 280,
        child: Card(
          color: selected ? const Color(0xFF6A8BB0) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
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
                    color: selected ? Colors.white : AppColors.grey1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: selected ? Colors.white : AppColors.grey3,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (isFullTime)
                          JobDetailItem(title: "Full Time", hasBorder: true),
                        if (isRemote)
                          JobDetailItem(title: "Remote", hasBorder: true),
                        if (isSenior)
                          JobDetailItem(title: "Senior", hasBorder: true),
                      ],
                    ),
                    SvgPicture.asset(AppAssets.save),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
