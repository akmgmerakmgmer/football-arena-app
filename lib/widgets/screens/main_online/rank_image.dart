import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_zone_app/utilities/media_query_height.dart';
import 'package:in_zone_app/widgets/containers/background_image_black.dart';
import 'package:in_zone_app/widgets/general_widgets/cached_image.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/main_online/rank_banner.dart';
import 'package:in_zone_app/widgets/screens/main_online/season_ends.dart';

class RankImage extends StatelessWidget {
  final Map user;
  final String locale;
  const RankImage({super.key, required this.user, required this.locale});

  @override
  Widget build(BuildContext context) {
    return BackgroundImageBlack(
        image: user['rank']['bgImage'],
        padding: const EdgeInsets.all(0),
        height: MediaQueryHeight().largeImageHeight(context),
        radius: 10,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              RankBanner(
                user: user,
                locale: locale,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize:
                            MainAxisSize.min, // Adjusts to content size
                        children: [
                           TextWidget(
                            title: user['system_info']['current_season']['title'][locale],
                            fontSize: 20,
                            uppercase: true,
                            fontWeight: FontWeight.w800,
                          ),
                          CachedImage(
                            image: user['rank']['image'],
                            width: 140,
                          ),
                        ],
                      ),
                    ),
                  ),
                   SeasonEnds(endsDate: user['system_info']['current_season']['endDate'],),
                ],
              ),
            ],
          ),
        ));
  }
}
