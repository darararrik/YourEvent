import 'package:YourEvent/screens/createEventPage/EventDetailsPage.dart';
import 'package:flutter/material.dart';

import '../../models/event.dart';

class EventTypeSelectionScreen extends StatelessWidget {
  const EventTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите тип события'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: EventType.values.map((eventType) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailsScreen(eventType: eventType),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(eventType.displayName),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}