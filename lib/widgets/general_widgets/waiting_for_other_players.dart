import 'package:flutter/material.dart';
import 'dart:async';

import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';

class WaitingForOtherPlayers extends StatefulWidget {
  final String title;
  const WaitingForOtherPlayers({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _WaitingForOtherPlayersState createState() => _WaitingForOtherPlayersState();
}

class _WaitingForOtherPlayersState extends State<WaitingForOtherPlayers> {
  int _dotCount = 1;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startDotAnimation();
  }

  void _startDotAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotCount = (_dotCount % 3) + 1; // Cycle through 1, 2, 3
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Stop the timer to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextWidget(
        title: '${widget.title}${'.' * _dotCount}', // Add dots dynamically
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
