import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:flutter_challenge_mobile/widgets/buttons/main_button_no_width.dart';
import 'package:flutter_challenge_mobile/widgets/containers/grid_container.dart';
import 'package:flutter_challenge_mobile/widgets/containers/page_container_with_footer.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/snackbar_message.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/title_with_border.dart';
import 'package:flutter_challenge_mobile/widgets/screens/profile/single_users_avatars.dart';
import 'package:flutter_challenge_mobile/widgets/user_inputs/input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AccountProfile extends StatelessWidget {
  AccountProfile({super.key});

  List<Map> avatars = [
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999199/bgl4bi1mwgyx063hqlrl.jpg',
      "price": 6
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999232/hwf7tvwntitssim3bnin.jpg',
      "price": 7
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999256/lyeqdkttphhgkbhotpce.jpg',
      "price": 8
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999282/jkulcncu57buwpfvalxu.jpg',
      "price": 2
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999312/e0mcpelurwowwvlhhtnq.jpg',
      "price": 25
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999342/z5byrvq7izwbmgonvg7b.jpg',
      "price": 3
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999365/cyivdbji0gkl7zcsk8je.jpg',
      "price": 5
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999387/cn3bvdsbdvchaqxech9p.jpg',
      "price": 10
    },
  ];

  @override
  Widget build(BuildContext context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    return PageContainerWithFooter(
        background: Theme.of(context).splashColor,
        body: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWithBorder(
                  title: AppLocalizations.of(context)!.accountProfile),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Theme.of(context).primaryColorDark),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Input(
                      callback: (value) {},
                      label: AppLocalizations.of(context)!.username,
                      value: "Ahmedddd",
                      disabled: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Input(
                      callback: (value) {},
                      label: AppLocalizations.of(context)!.password,
                      value: "MynameIsAhmedPassword",
                      disabled: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Input(
                      callback: (value) {},
                      label: AppLocalizations.of(context)!.number,
                      value: "01119683676",
                      disabled: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextWidget(
                      title: AppLocalizations.of(context)!.yourAvatars,
                      fontSize: 17,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GridContainer(
                      numberOfGrids: 4,
                      widget: user['avatars']
                          .map<Widget>((avatar) => SingleUsersAvatars(
                                isSelected: user['selectedAvatar']['image'] ==
                                    avatar['image'],
                                image: avatar['image'],
                                buttonText: user['selectedAvatar']['image'] ==
                                        avatar['image']
                                    ? AppLocalizations.of(context)!.selected
                                    : AppLocalizations.of(context)!.select,
                                api: 'users/${user['_id']}',
                                body: {"selectedAvatar": avatar},
                                callback: (res) {
                                  Provider.of<LocaleProvider>(context,
                                          listen: false)
                                      .setUser(res);
                                },
                                errorCallback: () {},
                              ))
                          .toList(),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextWidget(
                      title: AppLocalizations.of(context)!.buyMoreAvatars,
                      fontSize: 17,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MainButtonNoWidth(
                      radius: 10,
                      buttonText: '',
                      action: () {},
                      isWidget: true,
                      widget: IntrinsicWidth(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title:
                                  '${AppLocalizations.of(context)!.youHave} ${user['coins']}',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            const Icon(
                              Icons.donut_large,
                              color: Colors.yellow,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GridContainer(
                      numberOfGrids: 4,
                      widget: avatars
                          .map((avatar) => SingleUsersAvatars(
                                isSelected: false,
                                image: avatar['image'],
                                buttonText: 'Selected',
                                isWidget: true,
                                widget: Column(
                                  children: [
                                    TextWidget(
                                      title:
                                          AppLocalizations.of(context)!.buyNow,
                                      fontSize: 16,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextWidget(
                                          title: avatar['price'].toString(),
                                          fontSize: 14,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          Icons.donut_large,
                                          color: Colors.yellow,
                                          size: 18,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                api: 'buy-avatar/${user['_id']}',
                                body: {"avatar": avatar},
                                callback: (res) {
                                  Provider.of<LocaleProvider>(context,
                                          listen: false)
                                      .setUser(res['user']);
                                },
                                errorCallback: (err) {
                                  String message = Provider.of<LocaleProvider>(
                                                  context,
                                                  listen: false)
                                              .locale ==
                                          'ar'
                                      ? err['message']['ar']
                                      : err['message']['en'];
                                  SnackbarMessage().snackbar(context, message,
                                      color: Colors.red);
                                },
                              ))
                          .toList(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
