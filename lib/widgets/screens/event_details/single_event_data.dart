import 'package:flutter/material.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/screens/rankings/single_user_data.dart';

class SingleEventData extends StatelessWidget {
  final Map event;
  final String locale;
  final String userId;
  const SingleEventData({
    super.key,
    required this.event,
    required this.locale,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final rankings = event['rankings'] ?? [];
    if (rankings.isEmpty) {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: TextWidget(
            title: AppLocalizations.of(context)!.noRankedUsers,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: rankings
              .asMap()
              .entries
              .map<Widget>((entry) => SingleUserData(
                    isSameUser: entry.value['userId']['_id'].toString() ==
                        userId.toString(),
                    rank: '${entry.key + 1}',
                    item: entry.value['userId'],
                    points: entry.value['points'] ?? 0,
                    numberOfCoins: event['prizes'][entry.key]['coins'] ?? 0,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
