import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final Color? color;
  final Color? borderColor;
  bool light = false;
  final IconData? icon;
  final Color? textColor;
  bool block = false;

  Button(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color,
      this.borderColor,
      this.light = false,
      this.icon,
      this.textColor,
      this.block = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: block == true ? MediaQuery.of(context).size.width : 130,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.sp),
            border: Border.all(
                color: borderColor != null ? borderColor! : const Color(0xffDBE7E5))),
        child: ElevatedButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: light == false ? color : Colors.white,
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(40)),
          ),
          child: icon != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // k30HorizontalSpacing,
                    // k10HorizontalSpacing,
                    // k10HorizontalSpacing,
                    Icon(
                      icon,
                      color: light == false
                          ? Colors.white
                          : textColor ?? (color ?? Colors.blue),
                      size: 25,
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    // k5HorizontalSpacing,
                    Expanded(
                      child: Text("$text  ",
                          style: TextStyle(
                              letterSpacing: 1,
                              color: light == false
                                  ? Colors.white
                                  : textColor ?? (color ?? Colors.blue),
                              fontWeight: FontWeight.bold,
                              fontSize: 12)),
                    ),
                  ],
                )
              : Container(
                  child: Center(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              letterSpacing: 1,
                              color: textColor ??
                                  (light == false ? Colors.white : Colors.blue),
                              fontWeight: FontWeight.w700,
                              fontSize: 13)),
                    ),
                  ),
                ),
        ));
  }
}
