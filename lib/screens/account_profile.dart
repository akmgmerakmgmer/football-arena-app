import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/title_with_border.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_form.dart';
import 'package:in_zone_app/widgets/screens/profile/single_perk_profile.dart';
import 'package:in_zone_app/widgets/screens/profile/single_users_avatars.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AccountProfile extends StatelessWidget with ChangeNotifier {
  AccountProfile({super.key});

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
                    ProfileForm(
                        user: user,
                        setUser: (value) {
                          Provider.of<LocaleProvider>(context, listen: false)
                              .setUser(value);
                        }),
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
                    user.isNotEmpty && user['avatars'].isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: user['avatars']
                                  .map<Widget>((avatar) => SingleUsersAvatars(
                                        isSelected: user['selectedAvatar']
                                                ['image'] ==
                                            avatar['image'],
                                        image: avatar['image'],
                                        buttonText: user['selectedAvatar']
                                                    ['image'] ==
                                                avatar['image']
                                            ? AppLocalizations.of(context)!
                                                .selected
                                            : AppLocalizations.of(context)!
                                                .select,
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
                          )
                        : Container(),
                    const SizedBox(
                      height: 30,
                    ),
                    TextWidget(
                      title: AppLocalizations.of(context)!.yourPerks,
                      fontSize: 17,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    user.isNotEmpty && user['perks'].isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: user['perks']
                                  .asMap()
                                  .entries
                                  .map<Widget>((perk) => SinglePerkProfile(
                                        perk: perk.value,
                                        index: perk.key,
                                        callback: () {
                                          notifyListeners();
                                        },
                                      ))
                                  .toList(),
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
