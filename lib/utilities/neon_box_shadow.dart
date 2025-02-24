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
    return [
      BoxShadow(
        color: Colors.blue,
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(0, 0),
      ),
      BoxShadow(
        color: Colors.blue,
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(0, 0),
      ),
      BoxShadow(
        color: Colors.blue,
        spreadRadius: 0,
        blurRadius: 5,
        offset: const Offset(0, 0),
      ),
    ];
  }
}
