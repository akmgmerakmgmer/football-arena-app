import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/containers/blur_container_with_border.dart';
import 'package:in_zone_app/widgets/screens/main_online/single_result.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserResultsData extends StatelessWidget {
  final Map user;
  const UserResultsData({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final Map seasonResults = user['season_results'];
    return BlurContainerWithBorder(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UserImage(
          image: user['selectedAvatar']['image'],
          video: user['selectedAvatar']['video'],
          radius: 100,
          showVideo: true,
        ),
        SingleResult(
            text: AppLocalizations.of(context)!.wins,
            number: seasonResults['wins']),
        SingleResult(
            text: AppLocalizations.of(context)!.loses,
            number: seasonResults['loses']),
        SingleResult(
            text: AppLocalizations.of(context)!.draws,
            number: seasonResults['draws']),
        SingleResult(
            text: AppLocalizations.of(context)!.win_percentage,
            number: seasonResults['winning_percentage'])
      ],
    ));
  }
}
