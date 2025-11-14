import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';
import 'package:in_zone_app/widgets/screens/profile/empty_state_card.dart';
import 'package:in_zone_app/widgets/screens/profile/logout_button.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_form_card.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_hero_card.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_images.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_quick_actions.dart';
import 'package:in_zone_app/widgets/screens/profile/profile_section_header.dart';
import 'package:in_zone_app/widgets/screens/profile/single_perk_profile.dart';
import 'package:in_zone_app/widgets/screens/profile/single_users_avatars.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AccountProfile extends StatelessWidget {
  const AccountProfile({super.key});

  @override
  Widget build(BuildContext context) {
    chooseAvatar(avatar, context) {
      final localeProvider =
          Provider.of<LocaleProvider>(context, listen: false);
      final Map user = localeProvider.user;
      user['selectedAvatar'] = avatar['selectedAvatar'];
      localeProvider.setUser(user);
      PutApi('users/${user['_id']}', avatar, (res) {}, errorCallback: (err) {})
          .put(context);
    }

    final localeProvider = Provider.of<LocaleProvider>(context, listen: true);
    final Map user = localeProvider.user;
    final bool hasThemes = user.isNotEmpty && user['themes'].isNotEmpty;
    final bool hasPerks = user.isNotEmpty && user['perks'].isNotEmpty;

    final locale = localeProvider.locale;
    
    return PageContainerWithFooter(
      background: Theme.of(context).splashColor,
      body: user.isEmpty
          ? const PrimaryLoading()
          : PagesAssetBackground(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    
                    // Hero Header Card with Avatar, Stats, and Greeting
                    ProfileHeroCard(
                      user: user,
                      onAvatarTap: () {
                        ModalContainer.modal(
                          context,
                          Wrap(
                            runSpacing: 4,
                            spacing: 4,
                            children: List<Widget>.from(
                              user['avatars'].map<Widget>((avatar) =>
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      chooseAvatar(
                                          {'selectedAvatar': avatar},
                                          context);
                                    },
                                    child: ProfileImages(
                                      isSelected: user['selectedAvatar']
                                              ['image'] ==
                                          avatar['image'],
                                      image: avatar['image'],
                                      video: avatar['video'],
                                      showVideo: avatar['video'] != '',
                                    ),
                                  )),
                            ),
                          ),
                          AppLocalizations.of(context)!.yourAvatars,
                        );
                      },
                    ),
                    
                    // Quick Actions Card
                    const ProfileQuickActions(),
                    
                    // Profile Edit Form Card
                    ProfileFormCard(
                      user: user,
                      setUser: (value) => localeProvider.setUser(value),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Themes Section
                    ProfileSectionHeader(
                      title: AppLocalizations.of(context)!.yourThemes,
                      icon: Icons.palette,
                      count: hasThemes ? user['themes'].length : null,
                      showGetMore: !hasThemes,
                      onGetMoreTap: () {
                        Navigator.pushNamed(context, '/shop');
                      },
                    ),
                    
                    const SizedBox(height: 8),
                    
                    hasThemes
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: List<Widget>.from(
                                user['themes'].map<Widget>((theme) =>
                                    SingleUsersAvatars(
                                      isTheme: true,
                                      userId: user['_id'],
                                      isSelected:
                                          user['selectedTheme'] == theme,
                                      body: {"selectedTheme": theme},
                                      localeProvider: localeProvider,
                                      image: theme,
                                      showVideo: false,
                                    )),
                              ),
                            ),
                          )
                        : EmptyStateCard(
                            message: locale == 'en'
                                ? 'No themes yet. Visit the shop to get your first theme!'
                                : 'لا توجد ثيمات بعد. قم بزيارة المتجر للحصول على ثيمك الأول!',
                            actionLabel: locale == 'en' ? 'Visit Shop' : 'زيارة المتجر',
                            onActionTap: () {
                              Navigator.pushNamed(context, '/shop');
                            },
                            icon: Icons.palette_outlined,
                          ),
                    
                    const SizedBox(height: 24),
                    
                    // Perks Section
                    ProfileSectionHeader(
                      title: AppLocalizations.of(context)!.yourPerks,
                      icon: Icons.flash_on,
                      count: hasPerks ? user['perks'].length : null,
                      showGetMore: !hasPerks,
                      onGetMoreTap: () {
                        Navigator.pushNamed(context, '/shop');
                      },
                    ),
                    
                    const SizedBox(height: 8),
                    
                    hasPerks
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: List<Widget>.from(
                                user['perks'].asMap().entries.map<Widget>(
                                    (perk) => SinglePerkProfile(
                                          perk: perk.value,
                                          index: perk.key,
                                          callback: () {},
                                        )),
                              ),
                            ),
                          )
                        : EmptyStateCard(
                            message: locale == 'en'
                                ? 'No perks yet. Get power-ups from the shop to boost your gameplay!'
                                : 'لا توجد قوى خاصة بعد. احصل على قوى من المتجر لتعزيز لعبك!',
                            actionLabel: locale == 'en' ? 'Get Perks' : 'احصل على القوى',
                            onActionTap: () {
                              Navigator.pushNamed(context, '/shop');
                            },
                            icon: Icons.flash_on_outlined,
                          ),
                    
                    const SizedBox(height: 24),
                    
                    // Logout Button
                    const LogoutButton(),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}
