import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/default_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/user_perks_quantity.dart';
import 'package:provider/provider.dart';

class SinglePerkProfile extends StatefulWidget {
  final Map perk;
  final int index;
  final Function callback;
  const SinglePerkProfile({
    super.key,
    required this.perk,
    required this.index,
    required this.callback,
  });

  @override
  State<SinglePerkProfile> createState() => _SinglePerkShopState();
}

class _SinglePerkShopState extends State<SinglePerkProfile> {
  bool loading = false;

  void selectPerk() {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    List selectedPerks =
        user['perks'].where((perk) => perk['selected'] == true).toList();
    if (selectedPerks.length == 4) {
      SnackbarMessage().snackbar(
          context, AppLocalizations.of(context)!.perksError,
          color: Colors.red);
    } else {
      setState(() {
        loading = true;
      });
      PutApi('select-perk/${user['_id']}', {"index": widget.index}, (res) {
        Provider.of<LocaleProvider>(context, listen: false).setUser(res);
        widget.callback();

        setState(() {
          loading = false;
        });
      }).put(context);
    }
  }

  removePerk() {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    setState(() {
      loading = true;
    });
    PutApi('remove-perk/${user['_id']}', {"index": widget.index}, (res) {
      Provider.of<LocaleProvider>(context, listen: false).setUser(res);
      widget.callback();
      // SnackbarMessage().snackbar(
      //     context, AppLocalizations.of(context)!.congratsText,
      //     color: Colors.green[400]);
      setState(() {
        loading = false;
      });
    }).put(context);
  }

  @override
  Widget build(BuildContext context) {
    double width = 250;
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    return Container(
      margin: locale == 'en'
          ? const EdgeInsets.only(right: 18)
          : const EdgeInsets.only(left: 18),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: width,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Image.network(
                  widget.perk['id']['backgroundImage'],
                  fit: BoxFit.cover,
                  height: 450,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                color: Colors.black.withOpacity(0.6),
              ),
              width: width,
              height: 450,
            ),
            user.isNotEmpty
                ? Positioned(
                    top: 15,
                    left: 10,
                    child: UserPerksQuantity(quantity: widget.perk['quantity']))
                : Container(),
            Positioned(
              bottom: 15,
              width: width,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        widget.perk['id']['image'],
                        fit: BoxFit.cover,
                        width: 50,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            title: locale == 'en'
                                ? widget.perk['id']['title']['en']
                                : widget.perk['id']['title']['ar'],
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            width: width * 0.7,
                            child: TextWidget(
                              title: locale == 'en'
                                  ? widget.perk['id']['description']['en']
                                  : widget.perk['id']['description']['ar'],
                              fontSize: 15,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                      width: width * 0.7,
                      child: DefaultButton(
                        buttonText: widget.perk['selected']
                            ? AppLocalizations.of(context)!.remove
                            : AppLocalizations.of(context)!.selectPerk,
                        action: () {
                          if (widget.perk['selected']) {
                            removePerk();
                          } else {
                            selectPerk();
                          }
                        },
                        loading: loading,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
