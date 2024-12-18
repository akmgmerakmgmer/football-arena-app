import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/event_details.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image.dart';
import 'package:provider/provider.dart';

class SingleEvent extends StatefulWidget {
  final Map event;
  const SingleEvent({super.key, required this.event});

  @override
  State<SingleEvent> createState() => _SingleEventState();
}

class _SingleEventState extends State<SingleEvent> {
  eventDetails(context) {
    Map user = Provider.of<LocaleProvider>(context, listen: false).user;
    if (user.containsKey('username')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          settings: const RouteSettings(name: '/events'),
          builder: (context) => EventDetails(
            eventId: widget.event['_id'],
          ),
        ),
      );
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    String locale = Provider.of<LocaleProvider>(context, listen: false).locale;
    return GestureDetector(
      onTap: () {
        eventDetails(context);
      },
      child: Row(
        children: [
          EventImage(
            event: widget.event,
            locale: locale,
            showIcon: true,
          ),
          const SizedBox(
            width: 12,
          )
        ],
      ),
    );
  }
}
