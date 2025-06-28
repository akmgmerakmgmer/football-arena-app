import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/buttons/main_button_no_width.dart';

class LiveNow extends StatelessWidget {
  const LiveNow({super.key});

  @override
  Widget build(BuildContext context) {
    return MainButtonNoWidth(buttonText: 'Live Now', action: () {},fontSize: 14,radius: 10,);
  }
}
