// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class JobLogo extends StatelessWidget {
  final String logoUrl;
  const JobLogo({super.key, required this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,

      decoration: BoxDecoration(
        color: Color(0xFF3A77FF1A).withOpacity(0.1),
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
