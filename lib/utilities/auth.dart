import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/screens/event_details/prizes_content.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Auth {
  Future<bool> getUser(token, context) async {
    bool havePrize = false;
    await PostApi(
      'current-user',
      {
        'data': {'token': token}
      },
      (value) {
        print(value['free_coins']);
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(value['user']);
        if (value['prizes'].isNotEmpty) {
          ModalContainer.modal(
              context,
              PrizesContent(
                prizes: value['prizes'],
              ),
              AppLocalizations.of(context)!.congratulations, closeCallBack: () {
            Navigator.of(context).pushNamed('/');
          });
          havePrize = true;
        }
      },
    ).post(context);
    return havePrize;
  }

  Future<void> logout(context) async {
    Provider.of<LocaleProvider>(context, listen: false).setUser({});
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', '');
  }
}
