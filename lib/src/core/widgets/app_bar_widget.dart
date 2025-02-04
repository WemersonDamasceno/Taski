import 'package:flutter/material.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Transform.scale(
              scale: 1.33,
              child: Checkbox(
                value: true,
                onChanged: (value) {},
              )),
          Text("Taski", style: context.textTheme.titleSmall),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: [
              Text(
                "John",
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(width: 14),
              const SizedBox(
                height: 42,
                width: 42,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/1040880/pexels-photo-1040880.jpeg?auto=compress&cs=tinysrgb&w=800",
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
