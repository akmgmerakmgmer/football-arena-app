import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/questions.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/purchase_button.dart';
import 'package:in_zone_app/widgets/containers/neon_container.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SingleTheme extends StatefulWidget {
  final Map theme;
  const SingleTheme({
    super.key,
    required this.theme,
  });

  @override
  State<SingleTheme> createState() => _SingleThemeState();
}

class _SingleThemeState extends State<SingleTheme> {
  bool loading = false;
  Future<void> onClick() async {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.isEmpty) {
      Navigator.pushNamed(context, '/login');
    } else {
      setState(() {
        loading = true;
      });
      PutApi('buy-theme/${user['_id']}', {"theme": widget.theme}, (res) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(res['user']);
        SnackbarMessage().snackbar(
            context, AppLocalizations.of(context)!.congratsText,
            label: AppLocalizations.of(context)!.checkYourAccount, action: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Navigator.pushNamed(context, '/profile');
        });
        setState(() {
          loading = false;
        });
      }, errorCallback: (err) {
        String message =
            Provider.of<LocaleProvider>(context, listen: false).locale == 'ar'
                ? err['message']['ar']
                : err['message']['en'];
        SnackbarMessage().snackbar(context, message, error: true);
        setState(() {
          loading = false;
        });
      }).put(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(widget.theme['image']), fit: BoxFit.cover),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
                top: 8,
                right: 4,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings: const RouteSettings(name: '/questions'),
                        builder: (context) => Questions(
                          themePreview: widget.theme['image'],
                        ),
                      ),
                    );
                  },
                  child: const NeonContainer(
                    widget: Icon(
                      Icons.open_in_new,
                      color: Colors.white,
                      size: 20,
                      textDirection: TextDirection.ltr,
                    ),
                    padding: EdgeInsets.all(4),
                    radius: 100,
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    width: width > 1280
                        ? width * 0.1
                        : width > 1024
                            ? width * 0.2
                            : width > 450
                                ? width * 0.3
                                : width * 0.6,
                    child: PurchaseButton(
                      price: widget.theme['price'].toString(),
                      buttonText: AppLocalizations.of(context)!.buyNow,
                      action: () {
                        onClick();
                      },
                      loading: loading,
                    )),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ],
        ));
  }
}
