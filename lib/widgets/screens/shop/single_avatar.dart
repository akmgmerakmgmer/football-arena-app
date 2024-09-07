import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/purchase_button.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SingleAvatar extends StatefulWidget {
  final Map avatar;
  const SingleAvatar({
    super.key,
    required this.avatar,
  });

  @override
  State<SingleAvatar> createState() => _SingleAvatarState();
}

class _SingleAvatarState extends State<SingleAvatar> {
  bool loading = false;
  Future<void> onClick() async {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.isEmpty) {
      Navigator.pushNamed(context, '/login');
    } else {
      setState(() {
        loading = true;
      });
      PutApi('buy-avatar/${user['_id']}', {"avatar": widget.avatar}, (res) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setUser(res['user']);
        SnackbarMessage().snackbar(
            context, AppLocalizations.of(context)!.congratsText,
            color: Colors.green[400]);
        setState(() {
          loading = false;
        });
      }, errorCallback: (err) {
        String message =
            Provider.of<LocaleProvider>(context, listen: false).locale == 'ar'
                ? err['message']['ar']
                : err['message']['en'];
        SnackbarMessage().snackbar(context, message, color: Colors.red);
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
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Container(
              width: width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: CachedImage(
                  image: widget.avatar['image'],
                  height: 300,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 15,
              child: SizedBox(
                  width: width > 1280
                      ? width * 0.1
                      : width > 1024
                          ? width * 0.2
                          : width > 450
                              ? width * 0.3
                              : width * 0.6,
                  child: PurchaseButton(
                    price: widget.avatar['price'].toString(),
                    buttonText: AppLocalizations.of(context)!.buyNow,
                    action: () {
                      onClick();
                    },
                    loading: loading,
                  )))
        ],
      ),
    );
  }
}
