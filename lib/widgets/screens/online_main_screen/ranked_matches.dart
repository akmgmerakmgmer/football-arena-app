import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/generalMethods.dart';
import 'package:in_zone_app/widgets/screens/online_main_screen/carousel_container.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RankedMatches extends StatelessWidget {
  const RankedMatches({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    
    // Get real data from user provider
    final user = localeProvider.user;
    final systemInfo = user['system_info'] ?? {};
    final currentSeason = systemInfo['current_season'] ?? {};
    final seasonResults = user['season_results'] ?? {};
    
    // Calculate season end time
    DateTime? seasonEndTime;
    if (currentSeason['endDate'] != null) {
      try {
        seasonEndTime = DateTime.parse(currentSeason['endDate']);
      } catch (e) {
        seasonEndTime = null;
      }
    }
    
    // Calculate total matches played
    final wins = seasonResults['wins'] ?? 0;
    final loses = seasonResults['loses'] ?? 0;
    final draws = seasonResults['draws'] ?? 0;
    final totalMatches = wins + loses + draws;
    
    // Determine if it's popular (has activity)
    final isPopular = totalMatches > 0 || wins > 0;
    
    navigateToRankedMatches() {
      if (GeneralMethods().isUserExists(context)) {
        Navigator.pushNamed(context, '/main-online');
      } else {
        Navigator.pushNamed(context, '/signup');
      }
    }

    List rankedMatches = [
      {
        "image": "assets/images/ranked_match.jpg",
        "action": navigateToRankedMatches,
        "color": Colors.white.withOpacity(0.2),
        // Real engagement features
        "isPopular": isPopular,
        "showGlow": isPopular,
        "titleIcon": Icons.emoji_events,
        "urgencyEndTime": seasonEndTime,
      },
    ];
    return CarouselContainer(
        title: AppLocalizations.of(context)!.ranked_matches,
        desc: AppLocalizations.of(context)!.ranked_desc,
        locale: localeProvider.locale,
        data: rankedMatches);
  }
}
