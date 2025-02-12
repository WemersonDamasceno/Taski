import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/constants/app_images.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: SvgPicture.asset(AppImages.logoApp),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              Text(
                'John',
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(width: 14),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Container(
                  color: UIAppColors.slateBlue,
                  height: 42,
                  width: 42,
                  child: Image.network(
                    AppImages.avatar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('JW'));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
