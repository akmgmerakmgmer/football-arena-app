import 'package:flutter/material.dart';

class NeonBoxShadow {
  List<BoxShadow> customNeonShadow(Color color) {
    return [
      BoxShadow(
        color: color.withOpacity(0.7),
        blurRadius: 16,
        spreadRadius: 2,
      ),
      BoxShadow(
        color: color.withOpacity(0.4),
        blurRadius: 32,
        spreadRadius: 8,
      ),
    ];
  }

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
      Shadow(
          blurRadius: 6,
          color: Color(0xFFFFB3B3),
          offset: Offset(0, 0)), // soft glow
      Shadow(
          blurRadius: 12,
          color: Color(0xFFFF4D4D),
          offset: Offset(0, 0)), // lighter red
      Shadow(
          blurRadius: 20,
          color: Color(0xFFFF3C1A),
          offset: Offset(0, 0)), // main red
      Shadow(
          blurRadius: 32,
          color: Color(0xFFB30000),
          offset: Offset(0, 0)), // deep red
      Shadow(
          blurRadius: 48,
          color: Color(0x80FF4D4D),
          offset: Offset(0, 0)), // outer glow
    ];
  }

  // Magenta neon
  List<Shadow> magentaNeon(context) {
    return const [
      Shadow(blurRadius: 2, color: Colors.white, offset: Offset(0, 0)),
      Shadow(
          blurRadius: 6,
          color: Color(0xFFFFB3C6),
          offset: Offset(0, 0)), // soft magenta-pink
      Shadow(
          blurRadius: 12,
          color: Color(0xFFFF4DA6),
          offset: Offset(0, 0)), // lighter magenta-pink
      Shadow(
          blurRadius: 20,
          color: Color(0xFFFF007F),
          offset: Offset(0, 0)), // main magenta (reddish)
      Shadow(
          blurRadius: 32,
          color: Color(0xFFD50060),
          offset: Offset(0, 0)), // deep magenta-red
      Shadow(
          blurRadius: 48,
          color: Color(0x80FF4DA6),
          offset: Offset(0, 0)), // outer magenta glow
    ];
  }

  // Blue neon
  List<Shadow> blueNeon(context) {
    return const [
      Shadow(blurRadius: 2, color: Colors.white, offset: Offset(0, 0)),
      Shadow(
          blurRadius: 6,
          color: Color(0xFFB3E0FF),
          offset: Offset(0, 0)), // soft blue
      Shadow(
          blurRadius: 12,
          color: Color(0xFF4DC3FF),
          offset: Offset(0, 0)), // lighter blue
      Shadow(
          blurRadius: 20,
          color: Color(0xFF0099FF),
          offset: Offset(0, 0)), // main blue
      Shadow(
          blurRadius: 32,
          color: Color(0xFF005CB2),
          offset: Offset(0, 0)), // deep blue
      Shadow(
          blurRadius: 48,
          color: Color(0x804DC3FF),
          offset: Offset(0, 0)), // outer blue glow
    ];
  }

  // Gold neon - pure gold, only gold/yellow tones, no white or orange
  List<Shadow> goldNeon(context) {
    return const [
      Shadow(
          blurRadius: 4,
          color: Color(0xFFFFF700),
          offset: Offset(0, 0)), // bright gold
      Shadow(
          blurRadius: 12,
          color: Color(0xFFFFE100),
          offset: Offset(0, 0)), // rich gold
      Shadow(
          blurRadius: 24,
          color: Color(0xFFFFD700),
          offset: Offset(0, 0)), // main gold
      Shadow(
          blurRadius: 40,
          color: Color(0xFFFFC700),
          offset: Offset(0, 0)), // deep gold
      Shadow(
          blurRadius: 64,
          color: Color(0xFFFFB800),
          offset: Offset(0, 0)), // outer gold
      Shadow(
          blurRadius: 96,
          color: Color(0x66FFD700),
          offset: Offset(0, 0)), // soft gold glow
    ];
  }

  // Bronze neon - warm, coppery, brownish glow
  List<Shadow> bronzeNeon(context) {
    return const [
      Shadow(blurRadius: 2, color: Colors.white, offset: Offset(0, 0)),
      Shadow(
          blurRadius: 6,
          color: Color(0xFFD4A373),
          offset: Offset(0, 0)), // darker highlight
      Shadow(
          blurRadius: 14,
          color: Color(0xFFA27B5C),
          offset: Offset(0, 0)), // darker light bronze
      Shadow(
          blurRadius: 24,
          color: Color(0xFF8B5E34),
          offset: Offset(0, 0)), // darker main bronze
      Shadow(
          blurRadius: 36,
          color: Color(0xFF6F4518),
          offset: Offset(0, 0)), // deeper bronze
      Shadow(
          blurRadius: 56,
          color: Color(0xFF543100),
          offset: Offset(0, 0)), // rich dark bronze
      Shadow(
          blurRadius: 80,
          color: Color(0x668B5E34),
          offset: Offset(0, 0)), // outer bronze glow
    ];
  }

  // Silver neon - cool, bluish, metallic glow
  List<Shadow> silverNeon(context) {
    return const [
      Shadow(blurRadius: 2, color: Colors.white, offset: Offset(0, 0)),
      Shadow(
          blurRadius: 8,
          color: Color(0xFFE3F2FD),
          offset: Offset(0, 0)), // blueish highlight
      Shadow(
          blurRadius: 16,
          color: Color(0xFFB0BEC5),
          offset: Offset(0, 0)), // light silver
      Shadow(
          blurRadius: 24,
          color: Color(0xFF90A4AE),
          offset: Offset(0, 0)), // main silver
      Shadow(
          blurRadius: 36,
          color: Color(0xFF607D8B),
          offset: Offset(0, 0)), // deep silver
      Shadow(
          blurRadius: 56,
          color: Color(0xFFC0C0C0),
          offset: Offset(0, 0)), // metallic
      Shadow(
          blurRadius: 80,
          color: Color(0x6680D8FF),
          offset: Offset(0, 0)), // outer silver glow
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

  // Pink Red neon - vibrant pinkish red glow
  List<Shadow> pinkRedNeon(context) {
    return const [
      Shadow(blurRadius: 2, color: Colors.white, offset: Offset(0, 0)),
      Shadow(
          blurRadius: 6,
          color: Color(0xFFFFB3C6),
          offset: Offset(0, 0)), // soft pink
      Shadow(
          blurRadius: 12,
          color: Color(0xFFFF4D6D),
          offset: Offset(0, 0)), // pink-red
      Shadow(
          blurRadius: 20,
          color: Color(0xFFFF1744),
          offset: Offset(0, 0)), // main pinkish red
      Shadow(
          blurRadius: 32,
          color: Color(0xFFD50032),
          offset: Offset(0, 0)), // deep pink-red
      Shadow(
          blurRadius: 48,
          color: Color(0x80FF4D6D),
          offset: Offset(0, 0)), // outer pink-red glow
    ];
  }
}
