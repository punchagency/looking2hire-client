import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';

class ProfileJobHistoryCard extends StatelessWidget {
  final String companyLogo;
  final String jobTitle;
  final String jobDescription;
  final String startDate;
  final String endDate;
  final bool? isSaved;
  final bool? isNetworkImage;
  final Function()? onPressed;

  const ProfileJobHistoryCard({
    super.key,
    required this.companyLogo,
    required this.jobTitle,
    required this.jobDescription,
    required this.startDate,
    required this.endDate,
    this.isSaved,
    this.isNetworkImage,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.profileCardByGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 81,
            width: 92,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image:
                    isNetworkImage == true
                        ? NetworkImage(companyLogo)
                        : AssetImage(companyLogo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomRobotoText(
                        text: jobTitle,
                        textSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 13.0),
                      child: GestureDetector(
                        onTap: onPressed,
                        child: SvgPicture.asset(
                          height: 16,
                          width: 16,
                          AppAssets.edit,
                          color:
                              isSaved == true
                                  ? AppColor.arrowColor
                                  : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomRobotoText(
                  text: jobDescription,
                  textSize: 14,
                  fontWeight: FontWeight.w400,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textColor: AppColor.grey.shade500,
                ),
                SizedBox(height: 7),
                CustomRobotoText(
                  text: "$startDate • $endDate",
                  textSize: 12,
                  fontWeight: FontWeight.w400,
                  textColor: AppColor.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
