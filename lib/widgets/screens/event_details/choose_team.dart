import 'package:flutter/material.dart';
import 'package:in_zone_app/l10n/app_localizations.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/buttons/purchase_button.dart';
import 'package:in_zone_app/widgets/containers/pages_asset_background.dart';
import 'package:in_zone_app/widgets/general_widgets/snackbar_message.dart';
import 'package:in_zone_app/widgets/general_widgets/text_widget.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image.dart';
import 'package:in_zone_app/widgets/screens/event_details/choose_team/team_selection_card.dart';
import 'package:in_zone_app/widgets/screens/event_details/choose_team/event_details_card.dart';
import 'package:in_zone_app/widgets/screens/event_details/choose_team/enhanced_prize_preview.dart';
import 'package:in_zone_app/widgets/screens/event_details/choose_team/team_comparison_stats.dart';
import 'package:provider/provider.dart';

class ChooseTeam extends StatefulWidget {
  final Map event;
  final String locale;
  const ChooseTeam({
    super.key,
    required this.event,
    required this.locale,
  });

  @override
  State<ChooseTeam> createState() => _ChooseTeamState();
}

class _ChooseTeamState extends State<ChooseTeam> {
  bool buttonLoading = false;
  String selectedValue = '';

  void teamEvent() {}

  enterEvent() {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.containsKey('username')) {
      // if (user['coins'] < widget.event['price']) {
      //   return SnackbarMessage().snackbar(
      //       context, AppLocalizations.of(context)!.not_enough_coins,
      //       label: AppLocalizations.of(context)!.buy_coins,
      //       error: true, action: () {
      //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //     Navigator.pushNamed(context, '/shop');
      //   });
      // } else {
      //   Map eventPayload = {
      //     'eventId': widget.event['_id'],
      //     'endDate': widget.event['endDate'],
      //     'price': widget.event['price']
      //   };
      //   if (widget.event['isSinglePlayer'] != true &&
      //       widget.event['isMultiplayer'] != true) {
      //     if (selectedValue == '') {
      //       return SnackbarMessage().snackbar(
      //           context, AppLocalizations.of(context)!.chooseYourTeam,
      //           label: AppLocalizations.of(context)!.chooseYourTeamFirst,
      //           error: true, action: () {
      //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //         Navigator.pushNamed(context, '/shop');
      //       });
      //     } else {
      //       eventPayload['sideId'] = selectedValue;
      //     }
      //   }
      //   setState(() {
      //     buttonLoading = true;
      //   });
      //   PutApi('add-event/${user['_id']}', eventPayload, (res) {
      //     Provider.of<LocaleProvider>(context, listen: false).setUser(res);
      //     setState(() {
      //       buttonLoading = false;
      //     });
      //   }).put(context);
      // }
      Map eventPayload = {
        'eventId': widget.event['_id'],
        'endDate': widget.event['endDate'],
        'price': 0
      };
      if (widget.event['isSinglePlayer'] != true &&
          widget.event['isMultiplayer'] != true) {
        if (selectedValue == '') {
          return SnackbarMessage().snackbar(
              context, AppLocalizations.of(context)!.chooseYourTeam,
              label: AppLocalizations.of(context)!.chooseYourTeamFirst,
              error: true, action: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            Navigator.pushNamed(context, '/shop');
          });
        } else {
          eventPayload['sideId'] = selectedValue;
        }
      }
      setState(() {
        buttonLoading = true;
      });
      PutApi('add-event/${user['_id']}', eventPayload, (res) {
        Provider.of<LocaleProvider>(context, listen: false).setUser(res);
        setState(() {
          buttonLoading = false;
        });
      }).put(context);
    } else {
      Navigator.pushNamed(context, '/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTeamEvent = widget.event['isSinglePlayer'] != true &&
        widget.event['isMultiplayer'] != true;
    
    // Calculate total players from sides
    int totalPlayers = widget.event['number_of_players'] ?? 0;
    if (widget.event['sides'] != null && widget.event['sides'].isNotEmpty) {
      totalPlayers = 0;
      for (var side in widget.event['sides']) {
        totalPlayers += (side['numberOfPlayers'] ?? 0) as int;
      }
    }
    
    final endDate = widget.event['endDate'] != null
        ? DateTime.tryParse(widget.event['endDate'])
        : null;
    
    return PagesAssetBackground(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event Image
          EventImage(
            event: widget.event,
            locale: widget.locale,
          ),
          const SizedBox(height: 16),
          
          // Event Details Card
          EventDetailsCard(
            endDate: endDate,
            totalParticipants: totalPlayers,
            entryPrice: 0, // Always FREE
            locale: widget.locale,
            isSinglePlayer: widget.event['isSinglePlayer'] ?? false,
            isNew: false, // Set based on event creation date if available
          ),
          
          const SizedBox(height: 16),
          
          // Prize Preview
          if (widget.event['prizes'] != null &&
              widget.event['prizes'].isNotEmpty)
            EnhancedPrizePreview(
              prizes: widget.event['prizes'],
              locale: widget.locale,
              isSinglePlayer: widget.event['isSinglePlayer'] ?? false,
            ),
          
          const SizedBox(height: 16),
          
          // Event Description
          if (widget.event['description'] != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.white.withOpacity(0.7),
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextWidget(
                      title: widget.event['description'] is Map
                          ? (widget.event['description'][widget.locale] ?? '')
                          : (widget.event['description'] ?? ''),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                ],
              ),
            ),
          
          if (widget.event['description'] != null)
            const SizedBox(height: 16),
          
          // Team Comparison Stats
          if (isTeamEvent && widget.event['sides'] != null && widget.event['sides'].isNotEmpty)
            TeamComparisonStats(
              sides: widget.event['sides'],
              locale: widget.locale,
            ),
          
          if (isTeamEvent && widget.event['sides'] != null && widget.event['sides'].isNotEmpty)
            const SizedBox(height: 16),
          
          // Team Selection Header
          if (isTeamEvent)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.groups,
                    color: Theme.of(context).primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  TextWidget(
                    title: widget.locale == 'en'
                        ? 'CHOOSE YOUR TEAM'
                        : 'اختر فريقك',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                  const Spacer(),
                  if (selectedValue.isEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.orange.withOpacity(0.5),
                        ),
                      ),
                      child: TextWidget(
                        title: widget.locale == 'en' ? 'Required' : 'مطلوب',
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                ],
              ),
            ),
          
          const SizedBox(height: 8),
          
          // Team Selection Cards
          if (isTeamEvent && widget.event['sides'] != null)
            ...widget.event['sides'].asMap().entries.map((entry) {
              final index = entry.key;
              final side = entry.value;
              final sideId = side['_id'];
              final isSelected = sideId == selectedValue;
              final playerCount = side['numberOfPlayers'] ?? 0;
              
              // Determine most popular team (highest numberOfPlayers)
              int maxPlayers = 0;
              for (var s in widget.event['sides']) {
                final count = s['numberOfPlayers'] ?? 0;
                if (count > maxPlayers) maxPlayers = count;
              }
              final isPopular = playerCount == maxPlayers && playerCount > 0;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TeamSelectionCard(
                  teamId: sideId,
                  teamName: widget.locale == 'ar'
                      ? side['nameAr'] ?? 'فريق ${index + 1}'
                      : side['nameEn'] ?? 'Team ${index + 1}',
                  currentPlayers: playerCount,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      selectedValue = sideId;
                    });
                  },
                  locale: widget.locale,
                  sideIndex: index,
                  isPopular: isPopular,
                ),
              );
            }),
          
          const SizedBox(height: 16),
          
          // Enter Button
          PurchaseButton(
            buttonText: widget.event['isSinglePlayer']
                ? AppLocalizations.of(context)!.enter_event
                : AppLocalizations.of(context)!.choose,
            action: enterEvent,
            loading: buttonLoading,
            price: '0',
          ),
        ],
      ),
    );
  }
}
