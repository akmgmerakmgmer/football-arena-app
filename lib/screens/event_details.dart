import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/utilities/api_methods.dart';
import 'package:in_zone_app/widgets/containers/page_container_with_footer.dart';
import 'package:in_zone_app/widgets/screens/event_details/choose_team.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_details_loading.dart';
import 'package:in_zone_app/widgets/screens/event_details/team_results.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatefulWidget {
  final String eventId;
  const EventDetails({super.key, this.eventId = ''});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  bool loading = true;

  late Map event;
  fetchEvent() {
    FetchApi('events/${widget.eventId}', (res) {
      setState(() {
        loading = false;
        event = res;
      });
    }).fetch(context);
  }

  checkIfUserSelectedTeam() {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    List currentEvent = user['events']
        .where((userEvent) => userEvent['id'] == event['_id'])
        .toList();
    if (currentEvent.isNotEmpty && currentEvent[0]['id'] == event['_id']) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    fetchEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return PageContainerWithFooter(
        background: Theme.of(context).splashColor,
        body: loading
            ? const EventDetailsLoading()
            : checkIfUserSelectedTeam()
                ? TeamResults(
                    event: event,
                    locale: locale,
                  )
                : ChooseTeam(
                    event: event,
                    locale: locale,
                  ));
  }
}
