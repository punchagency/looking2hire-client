import 'package:flutter/material.dart';

class ProfilePhoto extends StatelessWidget {
  final String imageUrl;
  final double size;
  final bool? isNetwork;
  final VoidCallback? onPressed;

  const ProfilePhoto({super.key, required this.imageUrl, this.onPressed, this.size = 48, this.isNetwork});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          image: DecorationImage(
            // image: NetworkImage(imageUrl),
            image: isNetwork == true ? NetworkImage(imageUrl) : AssetImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
