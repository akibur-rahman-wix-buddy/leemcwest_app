// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leemcwest/assets_helper/app_colors.dart';

class CachedImageWidget extends StatelessWidget {
  String url;
  double? width;
  double? height;
  CachedImageWidget({
    super.key,
    required this.url,
    this.width,
    this.height
  });
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(150.r),
      child: CachedNetworkImage(
        placeholder: (context, url) => CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          radius: 25.r,
          child: const Icon(Icons.person, color: AppColors.cFFFFFF),
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          radius: 25.r,
          child: const Icon(Icons.error, color: AppColors.cFFFFFF),
        ),
        imageUrl: url,
        width: width ?? 110.h,
        height: height ?? 110.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
