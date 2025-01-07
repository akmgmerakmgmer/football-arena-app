import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/screens/event_details/prizes_content.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Auth {
  Future<void> getUser(token, context) async {
    await PostApi(
      'current-user',
      {
        'data': {'token': token}
      },
      (value) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(value['user']);
        if (value['prizes'].isNotEmpty) {
          ModalContainer.modal(
              context,
              PrizesContent(
                prizes: value['prizes'],
              ),
              AppLocalizations.of(context)!.congratulations);
        }
      },
    ).post(context);
  }

  Future<void> logout(context) async {
    Provider.of<LocaleProvider>(context, listen: false).setUser({});
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', '');
  }
}
