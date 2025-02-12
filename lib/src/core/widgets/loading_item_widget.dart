import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taski/src/core/constants/app_colors.dart';

class LoadingItemWidget extends StatelessWidget {
  const LoadingItemWidget({
    required this.width,
    required this.height,
    super.key,
    this.radius = 7,
    this.margin,
  });
  final double width;
  final double height;
  final double radius;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.mutedAzure,
      highlightColor: AppColors.mutedAzure.withOpacity(0.4),
      child: Container(
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
