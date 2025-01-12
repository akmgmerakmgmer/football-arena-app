import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/containers/triple_grid_container.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/general_widgets/title_with_border.dart';
import 'package:in_zone_app/widgets/screens/all_ranks/single_rank.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrevRanks extends StatelessWidget {
  const PrevRanks({super.key});

  @override
  Widget build(BuildContext context) {
    LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    String locale = localeProvider.locale;
    List prevRanks = localeProvider.user['prev_seasons_ranks'];
    return PageContainerWithFooter(
        background: Theme.of(context).splashColor,
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              TitleWithBorder(
                title: AppLocalizations.of(context)!.previous_ranks,
              ),
              const SizedBox(
                height: 16,
              ),
              prevRanks.isEmpty
                  ? TextWidget(
                      title: AppLocalizations.of(context)!.no_previous_rank,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  : TripleGridContainer(
                      widget: prevRanks
                          .map<Widget>((rank) => SingleRank(
                                rank: rank,
                                locale: locale,
                              ))
                          .toList(),
                    )
            ],
          ),
        ));
  }
}
