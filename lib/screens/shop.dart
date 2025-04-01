import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/screens/shop/buy_avatars.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/screens/shop/buy_coins.dart';
import 'package:in_zone_app/widgets/screens/shop/buy_perks.dart';
import 'package:in_zone_app/widgets/screens/shop/buy_themes.dart';
import 'package:in_zone_app/widgets/screens/shop/tabs_button.dart';
import 'package:provider/provider.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  bool loading = false;
  int pageNumber = 1;
  int numberOfPages = 1;
  List avatarsList = [];
  List themesList = [];
  int themePageNumber = 1;
  int themeNumberOfPages = 1;
  final ScrollController _scrollController = ScrollController();
  int activeTabIndex = 1;
  List activeTabs = [
    {"nameEn": "Avatars", "nameAr": "الرموز (افاتارز)", "index": 1},
    {"nameEn": "Themes", "nameAr": "الخلفيات", "index": 2},
    {"nameEn": "Perks", "nameAr": "وسائل المساعدة", "index": 3},
    {"nameEn": "Coins", "nameAr": "العملات", "index": 4},
  ];

  void tabAction(index) {
    setState(() {
      activeTabIndex = index;
    });
  }

  Future<void> fetchAvatars() async {
    if (Provider.of<LocaleProvider>(context, listen: false).avatars.isEmpty ||
        pageNumber > 1) {
      await FetchApi('avatars?page=$pageNumber', (avatars) {
        avatarsList.addAll(avatars['avatars']);
        Provider.of<LocaleProvider>(context, listen: false)
            .setAvatars(avatarsList);
        numberOfPages = (avatars['total_avatars'] / avatars['per_page']).ceil();
        // ignore: use_build_context_synchronously
      }).fetch(context);
    }
  }

  Future<void> fetchThemes() async {
    if (Provider.of<LocaleProvider>(context, listen: false).themes.isEmpty ||
        themePageNumber > 1) {
      await FetchApi('themes?page=$themePageNumber', (themes) {
        themesList.addAll(themes['themes']);
        Provider.of<LocaleProvider>(context, listen: false)
            .setThemes(themesList);
        themeNumberOfPages =
            (themes['total_themes'] / themes['per_page']).ceil();
        // ignore: use_build_context_synchronously
      }).fetch(context);
    }
  }

  Future<void> fetchShopItems() async {
    if (Provider.of<LocaleProvider>(context, listen: false).shopItems.isEmpty) {
      await FetchApi('shopItems', (shopItems) {
        Provider.of<LocaleProvider>(context, listen: false)
            .setShopItems(shopItems);
        // ignore: use_build_context_synchronously
      }).fetch(context);
    }
  }

  void initialFetch() async {
    setState(() {
      loading = true;
    });
    await fetchShopItems();
    await fetchAvatars();
    await fetchThemes();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (pageNumber != numberOfPages && activeTabIndex == 2) {
          pageNumber += 1;
          fetchAvatars();
        }
      }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (themePageNumber != themeNumberOfPages && activeTabIndex == 2) {
          themePageNumber += 1;
          fetchThemes();
        }
      }
    });
    initialFetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List avatars = Provider.of<LocaleProvider>(context, listen: false).avatars;
    List themes = Provider.of<LocaleProvider>(context, listen: false).themes;
    Map shopItems =
        Provider.of<LocaleProvider>(context, listen: false).shopItems;
    return PageContainerWithFooter(
        background: Theme.of(context).splashColor,
        scroll: _scrollController,
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Wrap(
                children: activeTabs
                    .map((tab) => TabsButton(
                        selected: activeTabIndex == tab['index'],
                        action: () => tabAction(tab['index']),
                        title:
                            Provider.of<LocaleProvider>(context, listen: false)
                                        .locale ==
                                    'en'
                                ? tab['nameEn']
                                : tab['nameAr']))
                    .toList(),
              ),
              activeTabIndex == 4
                  ? BuyCoins(
                      coins: shopItems.isEmpty ? [] : shopItems['coins'],
                      loading: loading,
                    )
                  : activeTabIndex == 3
                      ? BuyPerks(
                          perks: shopItems.isEmpty ? [] : shopItems['perks'],
                          loading: loading,
                        )
                      : activeTabIndex == 2
                          ? BuyThemes(
                              themes: themes.isEmpty ? [] : themes,
                              loading: loading)
                          : BuyAvatars(
                              avatars: avatars.isEmpty ? [] : avatars,
                              loading: loading,
                            )
            ],
          ),
        ));
  }
}
