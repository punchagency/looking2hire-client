import 'package:flutter/material.dart';
import 'package:looking2hire/features/home/widgets/job_detail_item.dart';
import 'package:looking2hire/features/home/widgets/job_logo.dart';
import 'package:looking2hire/reuseable/extensions.dart';

class JobCard extends StatelessWidget {
  final String logoUrl;
  final String price;
  final String title;
  final String location;
  final bool isFullTime;
  final bool isRemote;
  final bool isSenior;
  const JobCard(
      {super.key,
      required this.logoUrl,
      required this.price,
      required this.title,
      required this.location,
      required this.isFullTime,
      required this.isRemote,
      required this.isSenior});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        color: const Color(0xFF6A8BB0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                location,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                  Image.asset("save".toSvg)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
