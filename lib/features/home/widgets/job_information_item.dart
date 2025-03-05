// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:looking2hire/app_colors.dart';

class JobInformationItem extends StatelessWidget {
  final String title;
  final String? value;
  final double? fontSize;
  final List<String>? options;
  const JobInformationItem({
    super.key,
    required this.title,
    this.value,
    this.options, this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:  TextStyle(
            fontSize: fontSize ?? 14,
            fontWeight: FontWeight.w600,
            color: AppColors.lighterBlack,
          ),
        ),
        const SizedBox(height: 11),
        if (value != null)
          Text(
            value!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.lighterBlack,
            ),
          ),
        if (options != null)
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(options!.length, (index) {
              final option = options![index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CircleAvatar(
                      radius: 2,
                      backgroundColor: AppColors.lighterBlack,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lighterBlack,
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
      ],
    );
  }
}
