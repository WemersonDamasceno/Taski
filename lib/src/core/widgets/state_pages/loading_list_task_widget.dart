import 'package:flutter/material.dart';
import 'package:nova_design_system/core/widgets/item_shimmer/item_shimmer.dart';

class LoadingListTaskWidget extends StatelessWidget {
  const LoadingListTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return const UIItemShimmer(
          width: 200,
          height: 56,
          margin: EdgeInsets.only(top: 16),
        );
      },
    );
  }
}
