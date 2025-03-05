import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:looking2hire/app_colors.dart';

class JobDetailTabitem extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onPressed;
  const JobDetailTabitem({
    super.key,
    required this.title,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.lighterBlack,
          ),
        ),
      ),
    );
  }
}
