import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/widgets/containers/page_container_with_footer.dart';
import 'package:flutter_challenge_mobile/widgets/screens/home/about_us.dart';
import 'package:flutter_challenge_mobile/widgets/screens/home/main_menu.dart';
import 'package:flutter_challenge_mobile/widgets/screens/home/prizes.dart';
import 'package:flutter_challenge_mobile/widgets/screens/home/upcoming_challenges.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainerWithFooter(
      body: Column(
        children: [
          const MainMenu(),
          const AboutUs(),
          UpcomingChallenges(),
          Prizes()
        ],
      ),
    );
  }
}
