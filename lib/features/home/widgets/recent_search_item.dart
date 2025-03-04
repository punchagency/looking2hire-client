import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';

class RecentSearchItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onPressed;
  const RecentSearchItem(
      {super.key,
      required this.title,
      required this.selected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(6),
        border: selected
            ? Border.all(
                width: 0.6,
                color: AppColors.lightBlack.withOpacity(0.8),
              )
            : null,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.lightBlack,
        ),
      ),
    );
  }
}
