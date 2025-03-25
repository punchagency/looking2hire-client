import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/components/rounded_image.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/constants/app_color.dart';

class ProfileCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String address;
  final double? milesAway;
  final bool? isSaved;
  final bool showSave;
  final void Function()? onEdit;
  final void Function()? onSave;

  const ProfileCard({
    super.key,
    required this.name,
    required this.address,
    this.milesAway,
    this.isSaved,
    this.imageUrl,
    this.showSave = true,
    this.onEdit,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 120,
      padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: AppColor.profileCardByGrey,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoundedImage(imageUrl: imageUrl),
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
                if (milesAway != null) ...[
                  SizedBox(height: 5),

                  CustomRobotoText(
                    text: "$milesAway Miles Away",
                    textSize: 15,
                    fontWeight: FontWeight.w500,
                    textColor: AppColor.grey.shade500,
                  ),
                ],
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Flexible(
                //       child: CustomRobotoText(
                //         text: "$milesAway Miles Away",
                //         textSize: 15,
                //         fontWeight: FontWeight.w500,
                //         textColor: AppColor.grey.shade500,
                //       ),
                //     ),
                //     if (showSave)
                //       Padding(
                //         padding: const EdgeInsets.only(right: 8.0, top: 5),
                //         child: SvgPicture.asset(
                //           AppAssets.save,
                //           color: Colors.grey.shade600,
                //           height: 18,
                //         ),
                //       ),
                //   ],
                // ),
              ],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (onEdit != null)
                IconButton(
                  onPressed: onEdit,

                  padding: EdgeInsets.all(0),
                  icon: SvgPicture.asset(
                    AppAssets.edit,
                    color: Colors.grey.shade600,
                    height: 18,
                  ),
                ),
              if (onSave != null)
                IconButton(
                  onPressed: onSave,
                  padding: EdgeInsets.all(0),
                  icon: SvgPicture.asset(
                    AppAssets.save,
                    color: Colors.grey.shade600,
                    height: 18,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
