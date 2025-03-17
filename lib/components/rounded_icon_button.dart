import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedIconButton extends StatelessWidget {
  final String icon;
  final Color? color;
  final VoidCallback? onPressed;
  const RoundedIconButton({
    super.key,
    required this.icon,
    this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 30.0,
        height: 30.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFD9D9D9).withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: SvgPicture.asset(icon, color: color),
      ),
    );
  }
}
