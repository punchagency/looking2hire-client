import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';
import 'package:looking2hire/features/home/utils/utils.dart';

class RecentSearchItem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onPressed;
  const RecentSearchItem({
    super.key,
    required this.title,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onPressed,
      child: Container(
        height: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color:
              isWork && selected
                  ? AppColors.lightBlack
                  : AppColors.lightGrey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(6),
          border:
              isHire && selected
                  ? Border.all(
                    width: 0.6,
                    color: AppColors.lightBlack.withOpacity(0.8),
                  )
                  : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: isWork && selected ? Colors.white : AppColors.lightBlack,
          ),
        ),
      ),
    );
  }
}
