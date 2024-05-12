import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/containers/fade_transition.dart';

class BlackModalContainer extends StatelessWidget {
  final Widget body;
  const BlackModalContainer({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return FadeTransitionContainer(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark.withOpacity(0.4),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Center(
              child: IntrinsicHeight(
            child: body,
          ))),
    );
  }
}
