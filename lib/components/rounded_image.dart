import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/constants/app_assets.dart';

class RoundedImage extends StatelessWidget {
  final String? imageUrl;
  final String? defaultAssetImage;
  final double width;
  final double height;
  final double radius;
  final bool isFileImage;
  const RoundedImage({
    super.key,
    required this.imageUrl,
    this.width = 100,
    this.height = 100,
    this.defaultAssetImage,
    this.radius = 24,
    this.isFileImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(
          image:
              (imageUrl ?? "").isNotEmpty
                  ? isFileImage
                      ? FileImage(File(imageUrl!))
                      : CachedNetworkImageProvider(imageUrl!)
                  : AssetImage(defaultAssetImage ?? AppAssets.defaultProfilePic)
                      as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
