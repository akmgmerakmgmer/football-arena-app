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
  List<Shadow> redNeon(context) {
    return const [
      Shadow(blurRadius: 2, color: Colors.white, offset: Offset(0, 0)),
      Shadow(blurRadius: 6, color: Color(0xFFFFB3B3), offset: Offset(0, 0)), // soft glow
      Shadow(blurRadius: 12, color: Color(0xFFFF4D4D), offset: Offset(0, 0)), // lighter red
      Shadow(blurRadius: 20, color: Color(0xFFF61A1A), offset: Offset(0, 0)), // main red
      Shadow(blurRadius: 32, color: Color(0xFFB30000), offset: Offset(0, 0)), // deep red
      Shadow(blurRadius: 48, color: Color(0x80FF4D4D), offset: Offset(0, 0)), // outer glow
    ];
  }

  // Gold neon - pure gold, only gold/yellow tones, no white or orange
  List<Shadow> goldNeon(context) {
    return const [
      Shadow(blurRadius: 4, color: Color(0xFFFFF700), offset: Offset(0, 0)),   // bright gold
      Shadow(blurRadius: 12, color: Color(0xFFFFE100), offset: Offset(0, 0)),  // rich gold
      Shadow(blurRadius: 24, color: Color(0xFFFFD700), offset: Offset(0, 0)),  // main gold
      Shadow(blurRadius: 40, color: Color(0xFFFFC700), offset: Offset(0, 0)),  // deep gold
      Shadow(blurRadius: 64, color: Color(0xFFFFB800), offset: Offset(0, 0)),  // outer gold
      Shadow(blurRadius: 96, color: Color(0x66FFD700), offset: Offset(0, 0)),  // soft gold glow
    ];
  }

  // Bronze neon - warm, coppery, brownish glow
  List<Shadow> bronzeNeon(context) {
    return const [
      Shadow(blurRadius: 2, color: Colors.white, offset: Offset(0, 0)),
      Shadow(blurRadius: 6, color: Color(0xFFD4A373), offset: Offset(0, 0)), // darker highlight
      Shadow(blurRadius: 14, color: Color(0xFFA27B5C), offset: Offset(0, 0)), // darker light bronze
      Shadow(blurRadius: 24, color: Color(0xFF8B5E34), offset: Offset(0, 0)), // darker main bronze
      Shadow(blurRadius: 36, color: Color(0xFF6F4518), offset: Offset(0, 0)), // deeper bronze
      Shadow(blurRadius: 56, color: Color(0xFF543100), offset: Offset(0, 0)), // rich dark bronze
      Shadow(blurRadius: 80, color: Color(0x668B5E34), offset: Offset(0, 0)), // outer bronze glow
    ];
  }

  // Silver neon - cool, bluish, metallic glow
  List<Shadow> silverNeon(context) {
    return const [
      Shadow(blurRadius: 2, color: Colors.white, offset: Offset(0, 0)),
      Shadow(blurRadius: 8, color: Color(0xFFE3F2FD), offset: Offset(0, 0)), // blueish highlight
      Shadow(blurRadius: 16, color: Color(0xFFB0BEC5), offset: Offset(0, 0)), // light silver
      Shadow(blurRadius: 24, color: Color(0xFF90A4AE), offset: Offset(0, 0)), // main silver
      Shadow(blurRadius: 36, color: Color(0xFF607D8B), offset: Offset(0, 0)), // deep silver
      Shadow(blurRadius: 56, color: Color(0xFFC0C0C0), offset: Offset(0, 0)), // metallic
      Shadow(blurRadius: 80, color: Color(0x6680D8FF), offset: Offset(0, 0)), // outer silver glow
    ];
  }

  // White neon - less glowy, subtle effect for non-special places
  List<Shadow> whiteNeon(context) {
    return const [
      Shadow(blurRadius: 1, color: Colors.white, offset: Offset(0, 0)),
      Shadow(blurRadius: 4, color: Colors.white54, offset: Offset(0, 0)),
      Shadow(blurRadius: 8, color: Colors.white30, offset: Offset(0, 0)),
    ];
  }
}
