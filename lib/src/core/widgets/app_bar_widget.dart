import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/constants/app_images.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: SvgPicture.asset(AppImages.logoApp),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              Text(
                "John",
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(width: 14),
              SizedBox(
                height: 42,
                width: 42,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    color: AppColors.mutedAzure,
                    child: Image.network(
                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text("JW"));
                      },
                    ),
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
