import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:in_zone_app/utilities/url.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

class FetchApi {
  final String api;
  final Function callback;
  final dynamic errorCallback;
  FetchApi(this.api, this.callback, {this.errorCallback = ''});
  Future<void> fetch(context) async {
    final Uri url = Uri.parse("${Url().url}$api");
    await http.get(url, headers: await Url().requestHeaders()).then((response) => {
          if (response.statusCode >= 200 && response.statusCode < 300)
            {callback(jsonDecode(response.body))}
          else
            {
              SnackbarMessage().snackbar(
                  context, AppLocalizations.of(context)!.requestFailed,
                  color: Colors.red),
              errorCallback()
            }
        });
  }
}

class PostApi {
  final String api;
  Function callback;
  final Map body;
  final dynamic errorCallback;
  final String successMessage;
  PostApi(this.api, this.body, this.callback,
      {this.errorCallback = '', this.successMessage = ''});
  Future<void> post(context) async {
    final Uri url = Uri.parse("${Url().url}$api");
    await http
        .post(url, headers: await Url().requestHeaders(), body: jsonEncode(body))
        .then(
          (response) => {
            if (response.statusCode >= 200 && response.statusCode < 300)
              {
                callback(jsonDecode(response.body)),
                if (successMessage.isNotEmpty)
                  {
                    SnackbarMessage()
                        .snackbar(context, successMessage, color: Colors.green)
                  }
              }
            else if (response.statusCode == 422)
              {errorCallback(jsonDecode(response.body))}
            else
              {
                SnackbarMessage().snackbar(
                    context, AppLocalizations.of(context)!.requestFailed,
                    color: Colors.red)
              }
          },
        );
  }
}

class PutApi {
  final String api;
  Function callback;
  final Map body;
  final dynamic errorCallback;

  PutApi(this.api, this.body, this.callback, {this.errorCallback = ''});
  Future<void> put(context) async {
    final Uri url = Uri.parse("${Url().url}$api");
    await http
        .put(url, headers: await Url().requestHeaders(), body: jsonEncode(body))
        .then(
          (response) => {
            if (response.statusCode >= 200 && response.statusCode < 300)
              {callback(jsonDecode(response.body))}
            else if (response.statusCode == 422)
              {errorCallback(jsonDecode(response.body))}
            else
              {
                SnackbarMessage().snackbar(
                    context, AppLocalizations.of(context)!.requestFailed,
                    color: Colors.red)
              }
          },
        );
  }
}
