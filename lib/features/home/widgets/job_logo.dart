// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class JobLogo extends StatelessWidget {
  final String logoUrl;
  final double size;
  const JobLogo({super.key, required this.logoUrl, this.size = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,

      decoration: BoxDecoration(
        color: Color(0xff3a77ff1a).withOpacity(0.1),
        image: DecorationImage(
          image: AssetImage(logoUrl),
          // image: NetworkImage(logoUrl),
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
