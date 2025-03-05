import 'package:flutter/material.dart';

class MapUserMilesItem extends StatelessWidget {
  final String imageUrl;
  final int miles;
  final VoidCallback onPressed;
  const MapUserMilesItem({
    super.key,
    required this.imageUrl,
    required this.miles,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.87),
        boxShadow: [
          BoxShadow(
            offset: Offset(1.61, 1.61),
            color: Colors.black.withOpacity(0.35),
            blurRadius: 4.46,
          ),
        ],
      ),
    );
  }
}
