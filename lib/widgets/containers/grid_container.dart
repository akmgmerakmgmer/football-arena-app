import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridContainer extends StatelessWidget {
  final List<Widget> widget;
  final int numberOfGrids;
  const GridContainer(
      {super.key, required this.widget, this.numberOfGrids = 4});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
        crossAxisCount: MediaQuery.of(context).size.width > 1280
            ? numberOfGrids
            : MediaQuery.of(context).size.width > 1024
                ? 3
                : MediaQuery.of(context).size.width > 600
                    ? 2
                    : 1,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: widget);
  }
}
