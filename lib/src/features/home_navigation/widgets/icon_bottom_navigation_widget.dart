import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nova_design_system/nova_design_system.dart';

class IconBottomNavigationWidget extends StatelessWidget {
  const IconBottomNavigationWidget({
    required this.isSelected,
    required this.image,
    super.key,
  });
  final bool isSelected;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      fit: BoxFit.cover,
      height: 24,
      width: 24,
      colorFilter: ColorFilter.mode(
        isSelected ? UIAppColors.blue : UIAppColors.mutedAzure,
        BlendMode.srcIn,
      ),
    );
  }
}
