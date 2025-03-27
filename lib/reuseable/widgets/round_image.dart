import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:looking2hire/constants/app_assets.dart';

class RoundedImage extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final String? filePath;
  final double? radius;
  final double? size;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;

  const RoundedImage({
    super.key,
    this.imageUrl,
    this.onPressed,
    this.size,
    this.assetPath,
    this.radius,
    this.filePath,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final double _width = width ?? size ?? 48;
    final double _height = height ?? size ?? 48;
    final double _radius =
        radius ?? (size != null ? size! / 2 : min(height!, width!));
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(_radius),
      child: Container(
        width: _width,
        height: _height,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius),
          image: DecorationImage(
            image:
                (filePath ?? "").isNotEmpty
                    ? FileImage(File(filePath!))
                    : (imageUrl ?? "").isNotEmpty
                    ? CachedNetworkImageProvider(imageUrl!)
                    : AssetImage(assetPath ?? AppAssets.defaultProfilePic),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
