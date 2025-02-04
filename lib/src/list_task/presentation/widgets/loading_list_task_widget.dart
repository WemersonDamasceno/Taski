import 'package:flutter/material.dart';
import 'package:taski/src/core/widgets/loading_item_widget.dart';

class LoadingListTaskWidget extends StatelessWidget {
  const LoadingListTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LoadingItemWidget(
          width: 139,
          height: 24,
        ),
        const SizedBox(height: 8),
        const LoadingItemWidget(
          width: 200,
          height: 20,
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return const LoadingItemWidget(
                width: 200,
                height: 56,
                margin: EdgeInsets.only(top: 16),
              );
            },
          ),
        ),
      ],
    );
  }
}
