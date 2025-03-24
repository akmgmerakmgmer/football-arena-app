import 'package:flutter/material.dart';

class PauseAndPlay extends StatelessWidget {
  final bool isPlaying;
  final Function action;
  final bool isSound;
  const PauseAndPlay(
      {super.key,
      required this.isPlaying,
      required this.action,
      this.isSound = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Icon(
          isPlaying
              ? isSound
                  ? Icons.volume_up_sharp
                  : Icons.pause
              : isSound
                  ? Icons.volume_off_sharp
                  : Icons.play_arrow,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
