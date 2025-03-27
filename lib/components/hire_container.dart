// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';

class HireContainer extends StatelessWidget {
  final String title;
  final Widget? rightChild;
  final Widget? child;
  final double radius;
  final EdgeInsets? padding;

  const HireContainer({
    super.key,
    this.child,
    this.radius = 15,
    this.padding,
    required this.title,
    this.rightChild,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 24, horizontal: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.lightBlack.withOpacity(0.05),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.lightBlack,
                  ),
                ),
              ),
              if (rightChild != null) ...[
                const SizedBox(width: 8),
                rightChild!,
              ],
            ],
          ),
          if (child != null) ...[const SizedBox(height: 13), child!],
        ],
      ),
    );
  }
}
