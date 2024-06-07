import 'package:flutter/material.dart';
import 'package:flutter_challenge_mobile/providers/locale_provider.dart';
import 'package:flutter_challenge_mobile/utilities/api_methods.dart';
import 'package:flutter_challenge_mobile/widgets/containers/fade_transition.dart';
import 'package:flutter_challenge_mobile/widgets/containers/page_container_with_footer.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/text_widget.dart';
import 'package:flutter_challenge_mobile/widgets/loadings/primary_loading.dart';
import 'package:flutter_challenge_mobile/widgets/general_widgets/title_with_border.dart';
import 'package:flutter_challenge_mobile/widgets/screens/rankings/single_user.dart';
import 'package:flutter_challenge_mobile/widgets/user_inputs/dropdown_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class Rankings extends StatefulWidget {
  const Rankings({super.key});

  @override
  State<Rankings> createState() => _RankingsState();
}

class _RankingsState extends State<Rankings> {
  int rank = 0;
  Map user = {};
  List rankedUsers = [];
  final String search = '';
  String searchTime = 'weekly';
  int searchMonth = 1;
  int searchYear = 2024;
  String searchWeek = 'thisWeek';
  List<Map> searchByTime = [
    {
      "nameAr": 'الترتيب الأسبوعي',
      "nameEn": "Weekly Ranking",
      "value": 'weekly'
    },
    {
      "nameAr": 'الترتيب اليومي',
      "nameEn": "Daily Ranking",
      "value": 'daily'
    },
    {
      "nameAr": 'الترتيب الشهري',
      "nameEn": "Monthly Ranking",
      "value": 'monthly'
    },
    {"nameAr": 'ترتيب العام', "nameEn": "Yearly Ranking", "value": 'yearly'},
  ];
  List<Map> weeks = [
    {"nameEn": "This Week", "nameAr": "هذا الاسبوع", "value": "thisWeek"},
    {"nameEn": "Last Week", "nameAr": "الاسبوع السابق", "value": "lastWeek"}
  ];
  List<Map> months = [
    {"nameEn": "January", "nameAr": "يناير", "value": 1},
    {"nameEn": "February", "nameAr": "فبراير", "value": 2},
    {"nameEn": "March", "nameAr": "مارس", "value": 3},
    {"nameEn": "April", "nameAr": "ابريل", "value": 4},
    {"nameEn": "May", "nameAr": "مايو", "value": 5},
    {"nameEn": "June", "nameAr": "يونيو", "value": 6},
    {"nameEn": "July", "nameAr": "يوليو", "value": 7},
    {"nameEn": "August", "nameAr": "أغسطس", "value": 8},
    {"nameEn": "Septemper", "nameAr": "سبتمبر", "value": 9},
    {"nameEn": "October", "nameAr": "اكتوبر", "value": 10},
    {"nameEn": "November", "nameAr": "نوفمبر", "value": 11},
    {"nameEn": "December", "nameAr": "ديسمبر", "value": 12}
  ];
  List<Map> years = [
    {
      "nameAr": "2024",
      "nameEn": "2024",
      "value": 2024,
    }
  ];
  bool loading = false;
  bool openMenu = false;
  bool openWeeksMenu = false;
  bool openYearsMenu = false;
  bool openMonthsMenu = false;

  Future<void> getRankings() async {
    setState(() {
      loading = true;
    });
    bool isUserExists = Provider.of<LocaleProvider>(context, listen: false)
        .user
        .containsKey('username');
    late String userId;
    if (isUserExists) {
      userId = Provider.of<LocaleProvider>(context, listen: false).user['_id'];
    }
    String url = isUserExists
        ? 'get-user-rank/$userId?search=$search&searchByTime=$searchTime&week=$searchWeek&year=$searchYear&month=$searchMonth'
        : 'get-rankings?search=$search&searchByTime=$searchTime&week=$searchWeek&year=$searchYear&month=$searchMonth';
    await FetchApi(url, ((res) {
      if (res['rank'] != null) {
        setState(() {
          rank = res['rank'];
          setState(() {
            user = res['user'];
          });
        });
      }
      setState(() {
        rankedUsers = res['rankedUsers'];
        loading = false;
      });
    })).fetch(context);
  }

  void getYears() {
    DateTime currentDate = DateTime.now();
    int currentYear = currentDate.year;
    List years = [];
    for (var i = 2015; i <= currentYear; i++) {
      years.add({
        "nameAr": "$i",
        "nameEn": "$i",
        "value": i,
      });
    }
    setState(() {
      years = years;
    });
  }

  @override
  void initState() {
    getRankings();
    getYears();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<LocaleProvider>(context, listen: false)
            .user
            .containsKey('username')
        ? Provider.of<LocaleProvider>(context, listen: false).user['_id']
        : '';
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;

    return PageContainerWithFooter(
      background: Theme.of(context).splashColor,
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleWithBorder(title: AppLocalizations.of(context)!.tableRankings),
            const SizedBox(
              height: 15,
            ),
            DropDownWidget(
              items: searchByTime,
              initialValue: searchByTime[0]['value'],
              callback: (value) {
                setState(() {
                  searchTime = value;
                  getRankings();
                });
              },
              show: true,
            ),
            const SizedBox(
              height: 15,
            ),
            DropDownWidget(
              items: weeks,
              initialValue: weeks[0]['value'],
              callback: (value) {
                setState(() {
                  searchWeek = value;
                  getRankings();
                });
              },
              show: searchTime == 'weekly',
            ),
            DropDownWidget(
              items: years,
              initialValue: years[0]['value'],
              callback: (value) {
                setState(() {
                  searchYear = value;
                  getRankings();
                });
              },
              show: searchTime == 'yearly',
            ),
            DropDownWidget(
              items: months,
              initialValue: months[0]['value'],
              callback: (value) {
                setState(() {
                  searchMonth = value;
                  getRankings();
                });
              },
              show: searchTime == 'monthly',
            ),
            loading
                ? Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const PrimaryLoading())
                : rankedUsers.isNotEmpty
                    ? FadeTransitionContainer(
                        body: Container(
                          margin: const EdgeInsets.only(top: 10),
                          constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width),
                          child: Column(
                            children: [
                              Column(
                                children: rankedUsers
                                    .asMap()
                                    .entries
                                    .map((item) => SingleUser(
                                        locale: locale,
                                        currentFilter: searchTime,
                                        image: item.value['selectedAvatar']
                                            ['image'],
                                        gamesPlayed: item.value['games_played'],
                                        points: item.value['points'],
                                        coins: item.value['coins'],
                                        name: item.value['_id'] == userId
                                            ? '${item.value['username']} (${AppLocalizations.of(context)!.you})'
                                            : item.value['username'],
                                        isSameUser: item.value['_id'] == userId,
                                        rank: '${item.key + 1}',
                                        fontSize: locale == 'ar' ? 17 : 19))
                                    .toList(),
                              ),
                              rankedUsers.isNotEmpty &&
                                      rank > 10 &&
                                      userId != ''
                                  ? SingleUser(
                                      locale: locale,
                                      currentFilter: searchTime,
                                      image: user['selectedAvatar']['image'],
                                      gamesPlayed: user['games_played'],
                                      points: user['points'],
                                      coins: user['coins'],
                                      name: user['_id'] == userId
                                          ? '${user['username']} (${AppLocalizations.of(context)!.you})'
                                          : user['username'],
                                      isSameUser: user['_id'] == userId,
                                      rank: '$rank',
                                      fontSize: locale == 'ar' ? 17 : 19,
                                    )
                                  : Container()
                            ],
                          ),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: TextWidget(
                          title: AppLocalizations.of(context)!.noRankedUsers,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
