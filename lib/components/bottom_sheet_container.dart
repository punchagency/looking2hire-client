// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:looking2hire/constants/app_assets.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onClose;
  final bool showHandle;
  final bool useShadow;
  final double radius;
  final EdgeInsets? padding;
  final bool expanded;

  const BottomSheetContainer({
    super.key,
    this.child,
    this.onClose,
    this.showHandle = true,
    this.useShadow = true,
    this.radius = 30,
    this.padding,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        boxShadow:
            useShadow
                ? [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black.withOpacity(0.31),
                    blurRadius: 35,
                  ),
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black.withOpacity(0.09),
                    blurRadius: 63,
                  ),
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 85,
                  ),
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black.withOpacity(0.01),
                    blurRadius: 101,
                  ),
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.transparent,
                    blurRadius: 110,
                  ),
                ]
                : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showHandle)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: 28,
                  height: 2,
                  decoration: BoxDecoration(
                    color: const Color(0xFFBABABA),
                    borderRadius: BorderRadius.circular(34),
                  ),
                ),
              ),
            ),
          if (onClose != null)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onClose,
                child: SvgPicture.asset(AppAssets.close),
              ),
            ),
          const SizedBox(height: 10),
          if (child != null)
            if (expanded) Expanded(child: child!) else child!,
        ],
      ),
    );
  }
}
