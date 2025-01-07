import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DoubleGridContainer extends StatelessWidget {
  final List<Widget> widget;
  const DoubleGridContainer({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: widget);
  }
}
