import 'package:flutter/material.dart';
import 'package:looking2hire/components/custom_text.dart';
import 'package:looking2hire/constants/app_color.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget? rightChild;
  const CustomAppBar({super.key, required this.title, this.rightChild});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColor.arrowColor,
            )),
        SizedBox(
          width: 23,
        ),
        if (rightChild != null)
          rightChild!
        else
          CustomRobotoText(
            text: title,
            textSize: 32,
            fontWeight: FontWeight.w400,
          )
      ],
    );
  }
}
