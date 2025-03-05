import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/constants/app_assets.dart';

class MileItem extends StatelessWidget {
  final bool selected;
  final int index;
  final int mile;
  final ValueChanged<int> onChanged;
  const MileItem({
    super.key,
    required this.selected,
    required this.index,
    required this.mile,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(index),
      child: SizedBox(
        height: 42,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            selected
                ? SvgPicture.asset(AppAssets.location2)
                : CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.black.withOpacity(0.24),
                ),
            const SizedBox(height: 2),
            Text(
              "$mile mile${mile == 1 ? "" : "s"}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                color: AppColors.lighterBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
