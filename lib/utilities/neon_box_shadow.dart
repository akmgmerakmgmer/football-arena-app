import 'package:flutter/material.dart';

class NeonBoxShadow {
  List<BoxShadow> boxShadowNeon(context) {
    return [
      BoxShadow(
        color: Theme.of(context).primaryColor,
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(0, 0),
      ),
      BoxShadow(
        color: Theme.of(context).primaryColor,
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(0, 0),
      ),
      BoxShadow(
        color: Theme.of(context).primaryColor,
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(0, 0),
      ),
    ];
  }

  List<BoxShadow> boxShadowRed(context) {
    return [
      BoxShadow(
        color: Colors.red.shade600,
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(0, 0),
      ),
      BoxShadow(
        color: Colors.red.shade600,
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(0, 0),
      ),
      BoxShadow(
        color: Colors.red.shade600,
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(0, 0),
      ),
    ];
  }

  List<BoxShadow> boxShadowBlue(context) {
    return const [
      BoxShadow(
        color: Colors.blue,
        spreadRadius: 0,
        blurRadius: 5,
        offset: Offset(0, 0),
      ),
      BoxShadow(
        color: Colors.blue,
        spreadRadius: 0,
        blurRadius: 5,
        offset: Offset(0, 0),
      ),
      BoxShadow(
        color: Colors.blue,
        spreadRadius: 0,
        blurRadius: 5,
        offset: Offset(0, 0),
      ),
    ];
  }
List<Shadow> whiteNeon(context) {
  return const [
    Shadow(blurRadius: 3, color: Colors.white, offset: Offset(0, 0)),
    Shadow(blurRadius: 6, color: Color(0xFFFF4D4D), offset: Offset(0, 0)), // lighter red
    Shadow(blurRadius: 12, color: Color(0xFFF61A1A), offset: Offset(0, 0)), // main red
    Shadow(blurRadius: 20, color: Color(0xFFB30000), offset: Offset(0, 0)), // deeper red
  ];
}


}
