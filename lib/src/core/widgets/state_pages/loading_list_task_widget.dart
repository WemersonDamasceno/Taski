import 'package:flutter/material.dart';
import 'package:taski/src/core/widgets/loading_item_widget.dart';

class LoadingListTaskWidget extends StatelessWidget {
  const LoadingListTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoadingItemWidget(
          width: size.width,
          height: 56,
          margin: const EdgeInsets.only(top: 16),
        ),
        LoadingItemWidget(
          width: size.width,
          height: 56,
          margin: const EdgeInsets.only(top: 16),
        ),
        LoadingItemWidget(
          width: size.width,
          height: 56,
          margin: const EdgeInsets.only(top: 16),
        ),
      ],
    );
  }
}
