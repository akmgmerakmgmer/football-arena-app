import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TripleGridContainer extends StatelessWidget {
  final List<Widget> widget;
  const TripleGridContainer({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 8,
        children: widget);
  }
}
