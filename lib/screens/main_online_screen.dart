import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/casual_matches.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/friend_matches.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/ranked_matches.dart';

class MainOnlineScreen extends StatelessWidget {
  const MainOnlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainerWithFooter(
      background: Theme.of(context).splashColor,
      body: Container(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0, top: 8.0),
        child: const Column(
          children: [
            RankedMatches(),
            SizedBox(
              height: 10,
            ),
            CasualMatches(),
            SizedBox(
              height: 10,
            ),
            FriendMatches()
          ],
        ),
      ),
    );
  }
}
