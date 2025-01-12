import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/containers/triple_grid_container.dart';
import 'package:in_zone_app/widgets/screens/all_ranks/rank_loading.dart';
import 'package:in_zone_app/widgets/screens/all_ranks/single_rank.dart';
import 'package:provider/provider.dart';

class AllRanks extends StatefulWidget {
  const AllRanks({super.key});

  @override
  State<AllRanks> createState() => _AllRanksState();
}

class _AllRanksState extends State<AllRanks> {
  List ranks = [];
  late Map goatRank;
  bool loading = true;
  Future<void> getRanks() async {
    await FetchApi('/ranks', (res) {
      List updatedRanks = res['ranks'].sublist(1);
      setState(() {
        loading = false;
        ranks = updatedRanks;
        goatRank = res['ranks'][0];
      });
    }).fetch(context);
  }

  @override
  void initState() {
    getRanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String locale =
        Provider.of<LocaleProvider>(context, listen: false).locale;
    return PageContainerWithFooter(
        background: Theme.of(context).splashColor,
        body: loading
            ? const RankLoading()
            : Container(
                margin: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                child: Column(
                  children: [
                    SingleRank(rank: goatRank, locale: locale,alwaysEnglish: true,),
                    const SizedBox(
                      height: 8,
                    ),
                    TripleGridContainer(
                      widget: ranks
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
