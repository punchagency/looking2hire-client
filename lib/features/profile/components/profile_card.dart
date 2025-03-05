import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';

class ProfileCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String address;
  final double milesAway;
  final bool? isSaved;
  final bool showSave;

  const ProfileCard({
    super.key,
    required this.name,
    required this.address,
    required this.milesAway,
    this.isSaved,
    this.imageUrl,
    this.showSave = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.profileCardByGrey,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: DecorationImage(
                image: AssetImage(imageUrl ?? AppAssets.profileImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomRobotoText(
                  text: name,
                  textSize: 22,
                  fontWeight: FontWeight.w500,
                ),
                CustomRobotoText(
                  text: address,
                  textSize: 14,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w400,
                  textColor: AppColor.grey.shade500,
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRobotoText(
                      text: "$milesAway Miles Away",
                      textSize: 15,
                      fontWeight: FontWeight.w500,
                      textColor: AppColor.grey.shade500,
                    ),
                    if (showSave)
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 5),
                        child: SvgPicture.asset(
                          AppAssets.save,
                          color: Colors.grey.shade600,
                          height: 18,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
