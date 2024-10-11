import 'package:shared_preferences/shared_preferences.dart';

class Url {
  final String url = 'https://football-challenge-backend.onrender.com/api/';

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    if(token=='null'){
      return '';
    }
    return prefs.getString('token');
  }

  requestHeaders() async {
    String token = await getToken();
    if (token == '') {
      return {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
      };
    }
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Authorization': 'Bearer $token'
    };
  }
}
