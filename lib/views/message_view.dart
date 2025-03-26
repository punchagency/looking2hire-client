// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:looking2hire/app_colors.dart';

class MessageView extends StatelessWidget {
  final String message;
  final double? height;
  final double? width;
  const MessageView({Key? key, required this.message, this.height, this.width})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: AppColors.lightBlack),
      ),
    );
  }
}
