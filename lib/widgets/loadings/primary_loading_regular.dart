import 'package:flutter/material.dart';

class PrimaryLoadingRegular extends StatelessWidget {
  final double size;
  final String locale;
  const PrimaryLoadingRegular(
      {super.key, this.size = 15.0, required this.locale});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10,
      child: Align(
        alignment: locale == 'ar' ? Alignment.centerLeft : Alignment.centerRight,
        child: SizedBox(
          width: size,
          height: size,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
