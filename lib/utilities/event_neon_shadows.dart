import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/neon_box_shadow.dart';

class EventNeonShadows {
  static List<Shadow> get(String eventName, BuildContext context) {
    switch (eventName.toLowerCase()) {
      case 'bank':
        return NeonBoxShadow().blueNeon(context);
      case 'one shot':
        return NeonBoxShadow().magentaNeon(context);
      default:
        return NeonBoxShadow().redNeon(context);
    }
  }
}
