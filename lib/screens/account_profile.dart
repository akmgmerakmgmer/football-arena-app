import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/auth.dart';
import 'package:in_zone_app/widgets/buttons/default_button.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/title_with_border.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_form.dart';
import 'package:in_zone_app/widgets/screens/profile/single_perk_profile.dart';
import 'package:in_zone_app/widgets/screens/profile/single_users_avatars.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AccountProfile extends StatelessWidget {
  const AccountProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: true);
    final Map user = localeProvider.user;
    final bool hasAvatars = user.isNotEmpty && user['avatars'].isNotEmpty;
    final bool hasThemes = user.isNotEmpty && user['themes'].isNotEmpty;
    final bool hasPerks = user.isNotEmpty && user['perks'].isNotEmpty;

    return PageContainerWithFooter(
      background: Theme.of(context).splashColor,
      body: user.isEmpty
          ? const PrimaryLoading()
          : PagesAssetBackground(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWithBorder(
                      title: AppLocalizations.of(context)!.accountProfile),
                  const SizedBox(height: 15),
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
                          setUser: (value) => localeProvider.setUser(value),
                        ),
                        const SizedBox(height: 15),
                        TextWidget(
                          title: AppLocalizations.of(context)!.yourAvatars,
                          fontSize: 17,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 8),
                        hasAvatars
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List<Widget>.from(
                                    user['avatars'].map<Widget>((avatar) =>
                                      SingleUsersAvatars(
                                        isTheme: false,
                                        userId: user['_id'],
                                        isSelected: user['selectedAvatar']['image'] == avatar['image'],
                                        body: {"selectedAvatar": avatar},
                                        localeProvider: localeProvider,
                                        image: avatar['image'],
                                        video: avatar['video'],
                                        showVideo: avatar['video'] != '',
                                      )
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(height: 24),
                        TextWidget(
                          title: AppLocalizations.of(context)!.yourThemes,
                          fontSize: 17,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 8),
                        hasThemes
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List<Widget>.from(
                                    user['themes'].map<Widget>((theme) =>
                                      SingleUsersAvatars(
                                        isTheme: true,
                                        userId: user['_id'],
                                        isSelected: user['selectedTheme'] == theme,
                                        body: {"selectedTheme": theme},
                                        localeProvider: localeProvider,
                                        image: theme,
                                        showVideo: false,
                                      )
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(height: 24),
                        TextWidget(
                          title: AppLocalizations.of(context)!.yourPerks,
                          fontSize: 17,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 8),
                        hasPerks
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List<Widget>.from(
                                    user['perks'].asMap().entries.map<Widget>(
                                      (perk) => SinglePerkProfile(
                                        perk: perk.value,
                                        index: perk.key,
                                        callback: () {},
                                      )
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(height: 16),
                        DefaultButton(
                          loading: false,
                          isThereIconNext: true,
                          iconNext: const Icon(
                            Icons.logout,
                            size: 18,
                            color: Colors.white,
                          ),
                          buttonText: AppLocalizations.of(context)!.logout,
                          action: () {
                            Navigator.pushReplacementNamed(context, '/');
                            Auth().logout(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
