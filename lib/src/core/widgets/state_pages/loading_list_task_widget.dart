import 'package:flutter/material.dart';
import 'package:taski/src/core/widgets/loading_item_widget.dart';

class LoadingListTaskWidget extends StatelessWidget {
  const LoadingListTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return const LoadingItemWidget(
          width: 200,
          height: 56,
          margin: EdgeInsets.only(top: 16),
        );
      },
    );
  }
}
