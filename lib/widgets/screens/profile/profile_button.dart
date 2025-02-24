import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/main_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileButton extends StatefulWidget {
  final bool isSelected;
  final String userId;
  final Map body;
  final LocaleProvider localeProvider;
  final bool isTheme;
  const ProfileButton(
      {super.key,
      required this.isSelected,
      required this.userId,
      required this.body,
      required this.localeProvider,
      required this.isTheme});

  @override
  State<ProfileButton> createState() => _ProfileButtonState();
}

class _ProfileButtonState extends State<ProfileButton> {
  bool loading = false;
  Future<void> onClick() async {
    setState(() {
      loading = true;
    });
    PutApi('users/${widget.userId}', widget.body, (res) {
      widget.localeProvider.setUser(res);
      setState(() {
        loading = false;
      });
    }, errorCallback: (err) {
      setState(() {
        loading = false;
      });
    }).put(context);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 15,
        child: Container(
            width: MediaQuery.of(context).size.width * 0.4,
            constraints: const BoxConstraints(maxWidth: 200),
            child: MainButton(
              padding: const EdgeInsets.symmetric(vertical: 9.0,horizontal: 4.0),
              buttonText: widget.isSelected
                  ? widget.isTheme
                      ? AppLocalizations.of(context)!.selectedTheme
                      : AppLocalizations.of(context)!.selected
                  : widget.isTheme
                      ? AppLocalizations.of(context)!.selectTheme
                      : AppLocalizations.of(context)!.select,
              action: () {
                onClick();
              },
              radius: 10,
              fontSize: 13,
              uppercase: true,
              letterSpacing: 1.5,
              loading: loading,
            )));
  }
}
