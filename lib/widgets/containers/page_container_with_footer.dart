import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/utilities/auth.dart';
import 'package:in_zone_app/widgets/drawer/drawer_widget.dart';
import 'package:in_zone_app/widgets/footer/footer.dart';
import 'package:in_zone_app/widgets/general_widgets/bottom_navigation.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading.dart';
import 'package:in_zone_app/widgets/screens/questions/advertisment.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageContainerWithFooter extends StatefulWidget {
  final Widget body;
  final Color background;
  final Color footerBackground;
  final dynamic scroll;
  const PageContainerWithFooter(
      {super.key,
      required this.body,
      this.background = Colors.transparent,
      this.footerBackground = const Color(0xFF111111),
      this.scroll});

  @override
  State<PageContainerWithFooter> createState() =>
      _PageContainerWithFooterState();
}

class _PageContainerWithFooterState extends State<PageContainerWithFooter> {
  Timer? _adTimer;
  Timer? _skipAdTimer;
  bool loading = false;
  int currentAd = 0;
  int currentAdCountDown = 6;
  var overlayController = OverlayPortalController();

  void getLocale() async {
    if (Provider.of<LocaleProvider>(context, listen: false).locale == '') {
      SharedPreferences locale = await SharedPreferences.getInstance();
      dynamic currentLocale = locale.getString('locale');
      // ignore: use_build_context_synchronously
      Provider.of<LocaleProvider>(context, listen: false)
          .changeLocale(currentLocale == 'en' ? 'en' : 'ar');
    }
  }

  getInitialData() async {
    await fetchAdvertisments();
    adTimer();
    decreaseAdCount();
    await fetchUsers();
  }

  Future<void> fetchUsers() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString(('token'));
    if (token.toString() != 'null' &&
        token != '' &&
        // ignore: use_build_context_synchronously
        !Provider.of<LocaleProvider>(context, listen: false)
            .user
            .containsKey('username')) {
      // ignore: use_build_context_synchronously
      await Auth().getUser(token, context);
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> fetchAdvertisments() async {
    if (Provider.of<LocaleProvider>(context, listen: false)
        .advertisments
        .isEmpty) {
      setState(() {
        loading = true;
      });
      await FetchApi('advertisments?page=1', (advertisments) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setAdvertisments(advertisments);
        // ignore: use_build_context_synchronously
      }).fetch(context);
    }
  }

  void adTimer() {
    _adTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      Provider.of<LocaleProvider>(context, listen: false).setAdCountDown(
          Provider.of<LocaleProvider>(context, listen: false).adCountDown - 1);

      if (Provider.of<LocaleProvider>(context, listen: false).adCountDown ==
          0) {
        overlayController.toggle();
      }
    });
  }

  void adClicked(id) {
    PutApi('ad-clicked/$id', {}, (res) {}).put(context);
  }

  skipAdMethod() {
    if (currentAdCountDown <= 0) {
      overlayController.toggle();
      setState(() {
        Provider.of<LocaleProvider>(context, listen: false).setAdCountDown(181);
        currentAdCountDown = 6;
      });
      List advertisments = Provider.of<LocaleProvider>(context, listen: false)
          .advertisments['advertisments'];
      if (currentAd == advertisments.length - 1) {
        currentAd = 0;
      } else {
        currentAd++;
      }
    }
  }

  void decreaseAdCount() {
    _skipAdTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (Provider.of<LocaleProvider>(context, listen: false).adCountDown <=
          0) {
        setState(() {
          currentAdCountDown -= 1;
        });
      }
    });
  }

  @override
  void initState() {
    getLocale();
    getInitialData();
    super.initState();
  }

  @override
  void dispose() {
    // Cancel the timer when the page is disposed
    _adTimer?.cancel();
    _skipAdTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List advertisments = Provider.of<LocaleProvider>(context, listen: false)
                .advertisments
                .isNotEmpty &&
            Provider.of<LocaleProvider>(context, listen: false)
                .advertisments['advertisments']
                .isNotEmpty
        ? Provider.of<LocaleProvider>(context, listen: false)
            .advertisments['advertisments']
        : [];
    return SafeArea(
      child: Scaffold(
        endDrawer: const DrawerWidget(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(foregroundColor: Theme.of(context).splashColor,
            iconTheme: IconThemeData(color: Colors.grey.shade400),
            automaticallyImplyLeading: false,
            title: GestureDetector(
              onTap: () => {Navigator.pushNamed(context, '/')},
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                width: 55,
              ),
            ),
            elevation: 0, // Remove AppBar shadow
            backgroundColor: Theme.of(context).splashColor,
          ),
        ),
        // floatingActionButton: const FloatingButton(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                  // physics: const ScrollPhysics(parent:PageScrollPhysics() ),
                  child: Stack(
                children: [
                  Container(
                    color: widget.background,
                    child: loading
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            color: Theme.of(context).splashColor,
                            child: const PrimaryLoading())
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: advertisments.isNotEmpty
                                ? [
                                    OverlayPortal(
                                      controller: overlayController,
                                      overlayChildBuilder:
                                          (BuildContext context) {
                                        return Advertisment(
                                            adClicked: () => adClicked(
                                                advertisments[currentAd]
                                                    ['_id']),
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
            const BottomNavigation()
          ],
        ),
      ),
    );
  }
}
