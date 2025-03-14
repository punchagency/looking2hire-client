// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/components/title_information.dart';
import 'package:looking2hire/constants/app_assets.dart';
import 'package:looking2hire/extensions/context_extensions.dart';

class DialogContainer extends StatelessWidget {
  final String title;
  final String? hint;
  final String? message;
  final Widget? child;
  final List<Widget> actions;
  final double radius;
  final EdgeInsets? padding;

  const DialogContainer({
    super.key,
    this.child,
    this.radius = 15,
    this.padding,
    required this.title,
    this.hint,
    this.message,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 15),

      child: Padding(
        padding: padding ?? const EdgeInsets.all(20),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              top: 0,

              child: GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: SvgPicture.asset(AppAssets.close),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TitleInformation(title: title, hint: hint),
                ),
                if (message != null) ...[
                  const SizedBox(height: 32),
                  Text(
                    message!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF757575),
                    ),
                  ),
                ],
                if (child != null) child!,
                const SizedBox(height: 40),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: actions.length,
                    itemBuilder: (context, index) {
                      final action = actions[index];
                      return action;
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 30);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
