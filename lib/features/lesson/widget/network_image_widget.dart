import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_image.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double borderRadius;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    final double imageHeight = height ?? 80.h;
    final double imageWidth = width ?? double.infinity;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: imageWidth,
        height: imageHeight,
        fit: BoxFit.cover,
        placeholder: (context, url) => Image.asset(
          AppImages.classicalSheet,
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.classicalSheet,
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
