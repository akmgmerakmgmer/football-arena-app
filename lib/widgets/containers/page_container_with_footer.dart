import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/ad_methods.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/audio_manager.dart';
import 'package:in_zone_app/utilities/auth.dart';
import 'package:in_zone_app/utilities/external_url.dart';
import 'package:in_zone_app/utilities/get_app_version.dart';
import 'package:in_zone_app/utilities/image_manager.dart';
import 'package:in_zone_app/widgets/containers/modal_container.dart';
import 'package:in_zone_app/widgets/footer/footer.dart';
import 'package:in_zone_app/widgets/general_widgets/bottom_navigation.dart';
import 'package:in_zone_app/widgets/general_widgets/need_update.dart';
import 'package:in_zone_app/widgets/header/header.dart';
import 'package:in_zone_app/widgets/loadings/logo_loading.dart';
import 'package:in_zone_app/widgets/screens/questions/advertisment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageContainerWithFooter extends StatefulWidget {
  final Widget body;
  final Color background;
  final Color footerBackground;
  final dynamic scroll;
  final bool showHeader;
  const PageContainerWithFooter(
      {super.key,
      required this.body,
      this.background = Colors.transparent,
      this.footerBackground = const Color(0xFF111111),
      this.scroll,
      this.showHeader = true});

  @override
  State<PageContainerWithFooter> createState() =>
      _PageContainerWithFooterState();
}

class _PageContainerWithFooterState extends State<PageContainerWithFooter> {
  Timer? _adTimer;
  Timer? _skipAdTimer;
  bool loading = true;
  num currentAd = 0;
  int currentAdCountDown = 6;
  final overlayController = OverlayPortalController();
  String buildNumber = '';
  String lowestBuildNumber = '';

  void getLocale() async {
    if (Provider.of<LocaleProvider>(context, listen: false).locale == '') {
      final locale = await SharedPreferences.getInstance();
      final currentLocale = locale.getString('locale');
      
      if (currentLocale == null) {
        // Get the device locale
        final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale.languageCode;
        final isArabic = deviceLocale == 'ar';
        final newLocale = isArabic ? 'ar' : 'en';
        // Save the locale preference
        locale.setString('locale', newLocale);
        if (mounted) {
          Provider.of<LocaleProvider>(context, listen: false)
              .changeLocale(newLocale);
        }
      } else if (mounted) {
        Provider.of<LocaleProvider>(context, listen: false)
            .changeLocale(currentLocale);
      }
    }
  }

  void showRateAppModal() {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final user = localeProvider.user.isNotEmpty ? localeProvider.user : {};
    if (user.isNotEmpty &&
        !user['app_rated'] &&
        user['alreadyAsked'] == null &&
        user['season_results']['consecutive_wins'] >= 3) {
      user['alreadyAsked'] = true;
      ModalContainer.rateOurApp(context, localeProvider);
    }
  }

  Future<void> getInitialData() async {
    buildNumber = await getAppVersion();
    await initialFetch();
    adTimer();
    decreaseAdCount();
    await fetchUsers();
    showRateAppModal();
  }

  Future<void> initialFetch() async {
    AdMethods().createInterstitialAd(context);
    AudioManager().preloadAudios();
    ImageManager().preloadImages(context);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    if (localeProvider.advertisments.isEmpty) {
      setState(() {
        loading = true;
      });
      await FetchApi('initial-fetch', (data) {
        localeProvider.setAdvertisments(data['advertisments']);
        localeProvider.setEvents(data['events']);
        localeProvider.setChallenges(data['challenges']);
        final int intBuildNumber = int.tryParse(buildNumber) ?? 0;
        final int intLowestBuildNumber =
            int.tryParse(data['system']['lowestBuildNumber']) ?? 0;
        if (intBuildNumber < intLowestBuildNumber) {
          ModalContainer.updateModal(context, const NeedUpdate(),
              AppLocalizations.of(context)!.update_app_text);
        }
      }).fetch(context);
    }
  }

  Future<void> fetchUsers() async {
    final localStorage = await SharedPreferences.getInstance();
    final token = localStorage.getString('token');
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    if (token != null &&
        token != '' &&
        !localeProvider.user.containsKey('username')) {
      await Auth().getUser(token, context);
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  void adTimer() {
    _adTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
      localeProvider.setAdCountDown(localeProvider.adCountDown - 1);
      if (localeProvider.adCountDown == 0) {
        overlayController.toggle();
      }
    });
  }

  void adClicked(id, link) {
    PutApi('ad-clicked/$id', {}, (res) {}).put(context);
    ExternalUrl().launchNewUrl(link);
  }

  void skipAdMethod() {
    if (currentAdCountDown <= 0) {
      overlayController.toggle();
      final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
      setState(() {
        localeProvider.setAdCountDown(181);
        currentAdCountDown = 6;
      });
      final advertisments = localeProvider.advertisments['advertisments'];
      currentAd = (currentAd + 1) % advertisments.length;
    }
  }

  void decreaseAdCount() {
    _skipAdTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
      if (localeProvider.adCountDown <= 0) {
        setState(() {
          currentAdCountDown -= 1;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getLocale();
    getInitialData();
  }

  @override
  void dispose() {
    _adTimer?.cancel();
    _skipAdTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final advertisments = localeProvider.advertisments.isNotEmpty &&
            localeProvider.advertisments['advertisments'].isNotEmpty
        ? localeProvider.advertisments['advertisments']
        : [];
    return SafeArea(
      child: Scaffold(
        body: loading
            ? const LogoLoading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                        child: Stack(
                      children: [
                        Container(
                          color: widget.background,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: advertisments.isNotEmpty
                                ? [
                                    if (widget.showHeader) const Header(),
                                    OverlayPortal(
                                      controller: overlayController,
                                      overlayChildBuilder:
                                          (BuildContext context) {
                                        return Advertisment(
                                            adClicked: () => adClicked(
                                                advertisments[currentAd]['_id'],
                                                advertisments[currentAd]
                                                    ['directionLink']),
                                            seconds: currentAdCountDown,
                                            skipAdMethod: skipAdMethod,
                                            image: advertisments[currentAd]
                                                ['image']);
                                      },
                                      child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                              minHeight: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  200),
                                          child: widget.body),
                                    ),
                                    Footer(
                                        backgroundColor:
                                            widget.footerBackground)
                                  ]
                                : [
                                    Column(
                                      children: [
                                        if (widget.showHeader) const Header(),
                                        ConstrainedBox(
                                            constraints: BoxConstraints(
                                                minHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height -
                                                        200),
                                            child: widget.body),
                                        Footer(
                                            backgroundColor:
                                                widget.footerBackground)
                                      ],
                                    ),
                                  ],
                          ),
                        ),
                      ],
                    )),
                  ),
                  const BottomNavigation(),
                ],
              ),
      ),
    );
  }
}
