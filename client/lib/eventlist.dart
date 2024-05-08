
import 'package:flutter/material.dart';
import './models/event_model.dart';

class EventList extends StatelessWidget {
  final List<Event> events;
  final Function(Event) onEventSelected;
   const EventList({
    Key? key,
    required this.events,
    required this.onEventSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            onEventSelected(events[index]);
                        Navigator.pop(context);
          },
          title: Text(events[index].name),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(events[index].start.replaceFirst('T', ' ')),
              Text(events[index].description),
            ],
          ),
        );
      },
    );
  }

  
}
