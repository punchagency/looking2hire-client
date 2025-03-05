import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/constants/app_assets.dart';

import '../../../app_colors.dart';

class SetDistanceItem extends StatelessWidget {
  final String image;
  final String title;
  const SetDistanceItem({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(image),
        const SizedBox(width: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.lighterBlack,
          ),
        ),
      ],
    );
  }
}
