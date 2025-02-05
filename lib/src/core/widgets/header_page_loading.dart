import 'package:flutter/material.dart';
import 'package:taski/src/core/widgets/loading_item_widget.dart';

class HeaderPageLoading extends StatelessWidget {
  const HeaderPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LoadingItemWidget(
            width: 139,
            height: 24,
          ),
          SizedBox(height: 8),
          LoadingItemWidget(
            width: 200,
            height: 20,
          ),
          SizedBox(height: 24),
        ]);
  }
}
