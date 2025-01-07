import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/socket_methods.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/screens/home/question_mods.dart';
import 'package:in_zone_app/widgets/screens/main_online/rank_image.dart';
import 'package:in_zone_app/widgets/screens/main_online/rank_navs.dart';
import 'package:provider/provider.dart';

class MainOnline extends StatefulWidget {
  const MainOnline({super.key});

  @override
  State<MainOnline> createState() => _MainOnlineState();
}

class _MainOnlineState extends State<MainOnline> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    _socketMethods.joinRoomSuccesListener(context, localeProvider);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    Map user = localeProvider.user;
    String locale = localeProvider.locale;
    return PageContainerWithFooter(
        background: Theme.of(context).splashColor,
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              RankNavs(
                locale: locale,
                user: user,
              ),
              const SizedBox(
                height: 8,
              ),
              RankImage(
                user: user,
                locale: locale,
              ),
              const SizedBox(
                height: 16,
              ),
              const QuestionMods(isOnline: true,)
            ],
          ),
        ));
  }
}
