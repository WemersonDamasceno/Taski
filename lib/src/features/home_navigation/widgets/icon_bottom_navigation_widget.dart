import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taski/src/core/constants/app_colors.dart';

class IconBottomNavigationWidget extends StatelessWidget {
  final bool isSelected;
  final String image;

  const IconBottomNavigationWidget({
    super.key,
    required this.isSelected,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      fit: BoxFit.cover,
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(
        isSelected ? AppColors.blue : AppColors.mutedAzure,
        BlendMode.srcIn,
      ),
    );
  }
}
