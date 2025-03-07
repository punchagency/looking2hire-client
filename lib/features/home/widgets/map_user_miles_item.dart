// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:looking2hire/features/home/models/user.dart';
import 'package:looking2hire/resusable/widgets/profile_photo.dart';

class MapUserMilesItem extends StatelessWidget {
  final User user;
  final Function()? onPressed;
  const MapUserMilesItem({
    super.key,
    required this.user,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 40.0,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(1.61, 1.61),
              color: Colors.black.withOpacity(0.35),
              blurRadius: 4.46,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfilePhoto(imageUrl: user.imageUrl, size: 30),
            const SizedBox(width: 4),
            Text(
              "${user.miles} mile${user.miles == 1 ? "" : "s"}",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
