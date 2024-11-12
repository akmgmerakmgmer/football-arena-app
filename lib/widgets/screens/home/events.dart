import 'package:flutter/material.dart';
import 'package:in_zone_app/providers/locale_provider.dart';
import 'package:in_zone_app/widgets/screens/home/single_event.dart';
import 'package:provider/provider.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    List events = Provider.of<LocaleProvider>(context, listen: false).events;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: events
              .map((event) => SingleEvent(
                    event: event,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
