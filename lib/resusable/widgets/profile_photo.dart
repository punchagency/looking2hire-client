import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onPressed;
  const ProfilePhoto({super.key, required this.imageUrl, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
