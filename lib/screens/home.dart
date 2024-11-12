import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/screens/home/about_us.dart';
import 'package:in_zone_app/widgets/screens/home/events.dart';
import 'package:in_zone_app/widgets/screens/home/question_mods.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainerWithFooter(
      background: Theme.of(context).splashColor,
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Events(),
          QuestionMods(),
          // MainMenu(),
          AboutUs(),
          // UpcomingChallenges(),
          // Prizes()
        ],
      ),
    );
  }
}
