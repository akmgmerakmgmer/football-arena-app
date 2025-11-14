import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/screens/home/user_stats_display.dart';
import 'package:in_zone_app/widgets/screens/home/user_stats_login_prompt.dart';
import 'package:provider/provider.dart';

class UserStatsCard extends StatelessWidget {
  const UserStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        Map user = localeProvider.user;

        // If user not logged in, show login prompt
        if (user.isEmpty || !user.containsKey('username')) {
          return const UserStatsLoginPrompt();
        }

        // Show user stats
        return UserStatsDisplay(
          user: user,
          locale: localeProvider.locale,
        );
      },
    );
  }
}
