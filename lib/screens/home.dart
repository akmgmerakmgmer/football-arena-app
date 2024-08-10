import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/screens/home/about_us.dart';
import 'package:in_zone_app/widgets/screens/home/main_menu.dart';
import 'package:in_zone_app/widgets/screens/home/upcoming_challenges.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainerWithFooter(
      body: Column(
        children: [
          const MainMenu(),
          const AboutUs(),
          // UpcomingChallenges(),
          // Prizes()
        ],
      ),
    );
  }
}
