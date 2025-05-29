import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_container.dart';
import 'package:in_zone_app/widgets/screens/rankings/single_user_data.dart';

class SingleUser extends StatelessWidget {
  final dynamic item;
  final String rank;
  final bool isSameUser;
  final int numberOfCoins;
  const SingleUser(
      {super.key,
      required this.rank,
      required this.isSameUser,
      required this.item,
      required this.numberOfCoins});

  @override
  Widget build(BuildContext context) {
    final int rankInt = int.tryParse(rank) ?? 0;
    final int animationDelay = rankInt > 10
        ? 10 * 200
        : (rankInt - 1) * 200; // 200ms per user, rank starts from 1

    return FutureBuilder(
      future: Future.delayed(
          Duration(milliseconds: animationDelay < 0 ? 0 : animationDelay)),
      builder: (context, snapshot) {
        final show = snapshot.connectionState == ConnectionState.done;
        return AnimatedOpacity(
            opacity: show ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
            child: AnimatedSlide(
              offset: show ? Offset.zero : const Offset(-1.0, 0.0),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              child: BlurContainer(
                  child: SingleUserData(
                item: item,
                isSameUser: isSameUser,
                rank: rank,
                numberOfCoins: numberOfCoins,
              )),
            ));
      },
    );
  }
}
