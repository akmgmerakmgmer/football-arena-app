import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/screens/event_details.dart';
import 'package:in_zone_app/widgets/screens/event_details/event_image.dart';
import 'package:in_zone_app/widgets/animations/animated_button_wrapper.dart';
import 'package:provider/provider.dart';

class SingleEvent extends StatefulWidget {
  final int numberOfImages;
  final Map event;
  const SingleEvent({super.key, required this.event, this.numberOfImages = 1});

  @override
  State<SingleEvent> createState() => _SingleEventState();
}

class _SingleEventState extends State<SingleEvent> {
  late final bool _hasEnded;

  @override
  void initState() {
    super.initState();
    _hasEnded = _checkIfEventEnded();
  }

  bool _checkIfEventEnded() {
    if (!widget.event.containsKey('endDate')) return false;
    
    final endDate = DateTime.parse(widget.event['endDate']);
    final currentDate = DateTime.now();
    
    return currentDate.isAfter(endDate);
  }

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
      Navigator.pushNamed(context, '/signup');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasEnded) {
      return Container(); // Return empty container if event has ended
    }

    String locale = Provider.of<LocaleProvider>(context, listen: true).locale;
    return AnimatedButtonWrapper(
      onPressed: () {
        eventDetails(context);
      },
      child: Row(
        children: [
          EventImage(
            event: widget.event,
            numberOfImages: widget.numberOfImages,
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
