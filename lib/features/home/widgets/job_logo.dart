// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class JobLogo extends StatelessWidget {
  final String logoUrl;
  const JobLogo({
    Key? key,
    required this.logoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: NetworkImage(logoUrl),
            fit: BoxFit.contain,
            alignment: Alignment.center),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
