import 'package:flutter/material.dart';
import 'package:newsapp/app/utils/widgets/shimmer_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: NewsShimmer());
  }
}
