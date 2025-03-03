import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/screens/main_online/results_data.dart';
import 'package:in_zone_app/widgets/screens/questions/user_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserRankData extends StatelessWidget {
  final Map user;
  const UserRankData({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          UserImage(
            image: user['selectedAvatar']['image'],
            borderColor: Colors.transparent,
            imageSize: 100,
            video: user['selectedAvatar']['video'],
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ResultsData(
                    title: AppLocalizations.of(context)!.wins,
                    result: user['season_results']['wins'].toString()),
                ResultsData(
                    title: AppLocalizations.of(context)!.loses,
                    result: user['season_results']['loses'].toString()),
                ResultsData(
                    title: AppLocalizations.of(context)!.draws,
                    result: user['season_results']['draws'].toString()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
