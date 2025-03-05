import 'package:flutter/material.dart';

import '../../app_colors.dart';

class OutlinedContainer extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  const OutlinedContainer({super.key, required this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grey.withOpacity(0.2), width: 1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: child,
      ),
    );
  }
}
