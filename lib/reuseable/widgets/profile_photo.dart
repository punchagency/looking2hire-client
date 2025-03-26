import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/constants/app_assets.dart';

class ProfilePhoto extends StatelessWidget {
  final String? imageUrl;
  final String? defaultAssetImage;

  final double radius;
  final bool isFileImage;
  final double size;
  final bool? isNetwork;
  final VoidCallback? onPressed;

  const ProfilePhoto({
    super.key,
    this.imageUrl,
    this.onPressed,
    this.size = 48,
    this.isNetwork,
    this.defaultAssetImage,

    this.radius = 24,
    this.isFileImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        // decoration: BoxDecoration(
        //   color: Colors.transparent,
        //   shape: BoxShape.circle,
        //   image: DecorationImage(
        //     // image: NetworkImage(imageUrl),
        //     image:
        //         isNetwork == true
        //             ? CachedNetworkImageProvider(imageUrl)
        //             : AssetImage(imageUrl),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          image: DecorationImage(
            image:
                (imageUrl ?? "").isNotEmpty
                    ? isFileImage
                        ? FileImage(File(imageUrl!))
                        : CachedNetworkImageProvider(imageUrl!)
                    : AssetImage(
                          defaultAssetImage ?? AppAssets.defaultProfilePic,
                        )
                        as ImageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
