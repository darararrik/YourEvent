import 'package:flutter/material.dart';

import '../../firebase_service.dart';
import '../../models/event.dart';

class EventAdditionalDetailsScreen extends StatefulWidget {
  final EventType eventType;
  final String name;
  final DateTime date;
  final TimeOfDay time;
  final String description;

  const EventAdditionalDetailsScreen({
    super.key,
    required this.eventType,
    required this.name,
    required this.date,
    required this.time,
    required this.description,
  });

  @override
  _EventAdditionalDetailsScreenState createState() => _EventAdditionalDetailsScreenState();
}

class _EventAdditionalDetailsScreenState extends State<EventAdditionalDetailsScreen> {
  final TextEditingController _numOfPeopleController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  void _submitEvent() {
    final event = Event(
      name: widget.name,
      type: widget.eventType,
      numOfPeople: int.tryParse(_numOfPeopleController.text) ?? 0,
      date: widget.date,
      description: widget.description,
      budget: double.tryParse(_budgetController.text) ?? 0.0,
      uid: FirebaseService().currentUser!.uid,
    );

    FirebaseService().addEvent(event).then((value) {
      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дополнительные детали события'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _numOfPeopleController,
              decoration: const InputDecoration(labelText: 'Количество людей'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _budgetController,
              decoration: const InputDecoration(labelText: 'Бюджет'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'Город'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitEvent,
              child: const Text('Создать событие'),
            ),
          ],
        ),
      ),
    );
  }
}
