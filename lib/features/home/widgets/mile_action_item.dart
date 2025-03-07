import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/constants/app_assets.dart';

class MileActionItem extends StatelessWidget {
  final bool isIncrement;
  final VoidCallback onPressed;
  const MileActionItem({
    super.key,
    required this.isIncrement,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(9.2),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              isIncrement ? const Color(0xFF305BBB) : const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(9.2),
        ),
        child: SvgPicture.asset(
          isIncrement ? AppAssets.add : AppAssets.subtract,
        ),
      ),
    );
  }
}
