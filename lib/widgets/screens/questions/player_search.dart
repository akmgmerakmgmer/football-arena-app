import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_zone_app/screens/hints.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/fade_transition.dart';
import 'package:in_zone_app/widgets/loadings/primary_loading_regular.dart';
import 'package:in_zone_app/widgets/screens/questions/single_player.dart';
import 'package:easy_debounce/easy_debounce.dart';

class PlayerSearch extends StatefulWidget {
  final String locale;
  final bool isPlayerSearch;
  final List hints;
  final int questionHintsLength;
  final Function addHintAction;
  final Function skipAction;
  final Function playerAction;
  const PlayerSearch(
      {super.key,
      required this.locale,
      required this.isPlayerSearch,
      required this.hints,
      required this.questionHintsLength,
      required this.addHintAction,
      required this.skipAction,
      required this.playerAction});

  @override
  State<PlayerSearch> createState() => _PlayerSearchState();
}

class _PlayerSearchState extends State<PlayerSearch> {
  final TextEditingController _controller = TextEditingController(text: "");
  String playerValue = '';
  String previousValue = '';
  late List players = [];
  bool loading = false;

  emptySearch() {
    setState(() {
      _controller.text = '';
      players = [];
    });
  }

  @override
  void initState() {
    super.initState();
    // Add a listener to handle text changes
    _controller.addListener(_handleTextChange);
  }

  // Callback function to handle text changes
  void _handleTextChange() {
    if (_controller.text.length >= 3) {
      setState(() {
        loading = true;
      });
      EasyDebounce.debounce('debouncer1', const Duration(milliseconds: 300),
          () {
        FetchApi('players?name=${_controller.text}', ((res) {
          setState(() {
            loading = false;
            players = res['player'];
          });
        })).fetch(context);
        ;
      });
    }
    // You can also add logic here, such as updating state, validating text, etc.
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is removed from the widget tree
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPlayerSearch
        ? Stack(
            clipBehavior: Clip.none,
            children: [
              Hints(
                hints: widget.hints,
                locale: widget.locale,
                allHintsLength: widget.questionHintsLength,
                isPlayerSearch: widget.isPlayerSearch,
                addHintAction: widget.addHintAction,
                skipAction: widget.skipAction,
              ),
              Container(
                padding: EdgeInsets.only(
                    left: widget.locale == 'ar'
                        ? loading
                            ? 8
                            : 0
                        : 12,
                    right: widget.locale == 'ar'
                        ? 12
                        : loading
                            ? 8
                            : 00),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(8),
                      topRight: const Radius.circular(8),
                      bottomRight: players.isNotEmpty
                          ? const Radius.circular(0)
                          : const Radius.circular(8),
                      bottomLeft: players.isNotEmpty
                          ? const Radius.circular(0)
                          : const Radius.circular(8)),
                ),
                child: TextFormField(
                  controller: _controller,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  decoration: InputDecoration(
                    suffixIcon: loading
                        ? AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: PrimaryLoadingRegular(
                              locale: widget.locale,
                            ))
                        : GestureDetector(
                            onTap: emptySearch,
                            child: const Icon(
                              Icons.close,
                              color: Colors.white54,
                              size: 20,
                            ),
                          ),
                    border: InputBorder.none,
                    hintText: AppLocalizations.of(context)!.wordsLimit,
                    hintStyle:
                        const TextStyle(color: Colors.white54, fontSize: 15),
                  ),
                  cursorColor: Colors.white,
                ),
              ),
              players.isNotEmpty
                  ? FadeTransitionContainer(
                      body: Container(
                        height: players.isNotEmpty
                            ? 200
                            : 0, // Adjust height based on list state
                        margin:
                            const EdgeInsets.only(top: 40, left: 10, right: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                        ),
                        child: ListView.builder(
                          itemCount:
                              players.length, // Number of players in the list
                          itemBuilder: (context, index) {
                            return SinglePlayer(
                              player: players[index], // Access player by index
                              locale: widget.locale,
                              action: () {
                                widget.playerAction(
                                    players[index]['nameEn'], 0);
                                emptySearch();
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : Container()
            ],
          )
        : Container();
  }
}
