import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/screens/event_details/prizes_content.dart';
import 'package:in_zone_app/widgets/screens/questions/rank_change.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnlineMethods {
  Future<void> gameDoneMethod(api, winnerId, usedPerks, context) async {
    Map room = Provider.of<LocaleProvider>(context, listen: false).room;
    String userId = Provider.of<LocaleProvider>(context, listen: false)
        .user['_id']
        .toString();
    if (!room['isCasual'] && (room['code'] == '' || room['code'] == null)) {
      Map payload = {
        'userId': userId,
        'winnerId': winnerId,
        'players': room['players'],
        'roomId': room['_id'],
        'usedPerks': usedPerks
      };
      await PutApi('$api/$userId', payload, (res) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(res['user']);
        if (res['promoted'] != null && res['promoted']) {
          promotionMethod(res['prizes'], context);
        }

        if (res['demoted'] != null && res['demoted']) {
          demotionMethod(context);
        }
      }).put(context);
    }
  }

  void promotionMethod(prizes, context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    ModalContainer.modal(context, RankChange(user: user, locale: locale),
        AppLocalizations.of(context)!.you_have_been_promoted,
        closeCallBack: () {
      ModalContainer.modal(
        context,
        PrizesContent(prizes: prizes),
        AppLocalizations.of(context)!.congratulations,
      );
    });
  }

  void demotionMethod(context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    ModalContainer.modal(
      context,
      RankChange(user: user, locale: locale),
      AppLocalizations.of(context)!.you_have_been_demoted,
    );
  }

  Future<void> winnerUpdate(userId, usedPerks, context) async {
    await gameDoneMethod('multi-game-winner', userId, usedPerks, context);
  }

  Future<void> loserUpdate(userId, usedPerks, context) async {
    String winnerId = '';
    List players =
        Provider.of<LocaleProvider>(context, listen: false).room['players'];
    for (var player in players) {
      if (player['userId']['_id'] != userId) {
        winnerId = player['userId']['_id'];
      }
    }
    await OnlineMethods()
        .gameDoneMethod('multi-game-loser', winnerId, usedPerks, context);
  }

  Future<void> drawUpdate(usedPerks, context) async {
    await OnlineMethods()
        .gameDoneMethod('multi-game-draw', '', usedPerks, context);
  }
}
