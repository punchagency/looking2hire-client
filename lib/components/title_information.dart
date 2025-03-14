import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';

class TitleInformation extends StatelessWidget {
  final String title;
  final String? hint;
  const TitleInformation({super.key, required this.title, this.hint});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlack,
          ),
        ),
        if (hint != null) ...[
          const SizedBox(height: 8),
          Text(
            hint!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF757575),
            ),
          ),
        ],
      ],
    );
  }
}
