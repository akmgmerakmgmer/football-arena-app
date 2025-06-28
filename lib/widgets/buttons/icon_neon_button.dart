import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';

class IconNeonButton extends StatelessWidget {
  final Function action;
  final double size;
  final double radius;
  final bool loading;
  final EdgeInsets padding;
  final IconData icon;

  const IconNeonButton({
    super.key,
    required this.action,
    this.size = 24,
    this.radius = 100,
    this.loading = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: padding,
            child: loading
                ? const PrimaryLoading()
                : Icon(
                    icon,
                    size: size,
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }
}
