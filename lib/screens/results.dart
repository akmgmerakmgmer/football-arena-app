import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/header/header_with_desc.dart';
import 'package:in_zone_app/widgets/screens/results/single_result.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    return PageContainerWithFooter(
        background: Theme.of(context).splashColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeaderWithDesc(
                  title: AppLocalizations.of(context)!.season_results,
                  desc: AppLocalizations.of(context)!.last_20_results),
              const SizedBox(
                height: 16,
              ),
              user['season_results']['results'].length == 0
                  ? TextWidget(
                      title: AppLocalizations.of(context)!.no_results,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  : Column(
                      children: user['season_results']['results']
                          .map<Widget>((result) => Column(
                                children: [
                                  SingleResult(
                                    result: result,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  )
                                ],
                              ))
                          .toList())
            ],
          ),
        ));
  }
}
