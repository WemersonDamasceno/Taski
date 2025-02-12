import 'package:flutter/material.dart';
import 'package:nova_design_system/nova_design_system.dart';

class HeaderPageLoading extends StatelessWidget {
  const HeaderPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIItemShimmer(
          width: 139,
          height: 24,
        ),
        SizedBox(height: 8),
        UIItemShimmer(
          width: 200,
          height: 20,
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
