import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/loadings/pulse_animation.dart';

class LogoLoading extends StatelessWidget {
  const LogoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).splashColor,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        // Center the pulsing logo
        child: SizedBox(
          width: 150,
          child: PulseAnimation(
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
