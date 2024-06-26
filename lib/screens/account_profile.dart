import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/buttons/main_button_no_width.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/title_with_border.dart';
import 'package:in_zone_app/widgets/screens/profile/single_users_avatars.dart';
import 'package:in_zone_app/widgets/user_inputs/input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AccountProfile extends StatelessWidget {
  AccountProfile({super.key});

  List<Map> avatars = [
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999232/hwf7tvwntitssim3bnin.jpg',
      "price": 800
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999256/lyeqdkttphhgkbhotpce.jpg',
      "price": 550
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999282/jkulcncu57buwpfvalxu.jpg',
      "price": 700
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999312/e0mcpelurwowwvlhhtnq.jpg',
      "price": 200
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999342/z5byrvq7izwbmgonvg7b.jpg',
      "price": 500
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999365/cyivdbji0gkl7zcsk8je.jpg',
      "price": 150
    },
    {
      "image":
          'http://res.cloudinary.com/do0qe5hin/image/upload/v1711999387/cn3bvdsbdvchaqxech9p.jpg',
      "price": 1500
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
                      value: user['username'],
                      disabled: true,
                      icon: const Icon(Icons.person_outlined),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Input(
                        callback: (value) {},
                        label: AppLocalizations.of(context)!.password,
                        value: user['password'],
                        isPassword: true,
                        disabled: true,
                        icon: const Icon(Icons.lock_outlined)),
                    const SizedBox(
                      height: 15,
                    ),
                    Input(
                        callback: (value) {},
                        label: AppLocalizations.of(context)!.number,
                        value: user['number'],
                        disabled: true,
                        icon: const Icon(Icons.phone_outlined)),
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: user['avatars']
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: avatars
                            .map((avatar) => SingleUsersAvatars(
                                  isSelected: false,
                                  image: avatar['image'],
                                  buttonText: 'Selected',
                                  isWidget: true,
                                  widget: Column(
                                    children: [
                                      TextWidget(
                                        title: AppLocalizations.of(context)!
                                            .buyNow,
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
                                    String message =
                                        Provider.of<LocaleProvider>(context,
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
