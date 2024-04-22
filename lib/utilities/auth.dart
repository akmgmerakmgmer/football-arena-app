import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:flutter_challenge_mobile/utilities/api_methods.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  Future<void> getUser(token, context) async {
    await PostApi(
      'current-user',
      {
        'data': {'token': token}
      },
      (value) {
        Provider.of<LocaleProvider>(context, listen: false).setUser(value);
      },
    ).post(context);
  }

  Future<void> logout(context) async {
    Provider.of<LocaleProvider>(context, listen: false).setUser({});
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', '');
  }
}
