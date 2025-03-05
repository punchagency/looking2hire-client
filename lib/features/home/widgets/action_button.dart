// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const ActionButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5.89),
            color: AppColors.blue.withOpacity(0.2),
            blurRadius: 17.66,
          ),
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
