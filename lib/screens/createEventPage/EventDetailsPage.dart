import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/event.dart';
import 'EventAdditionalDetailsPage.dart';

class EventDetailsScreen extends StatefulWidget {
  final EventType eventType;

  const EventDetailsScreen({super.key, required this.eventType});

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Детали события: ${widget.eventType.displayName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: _selectDate,
              child: Text(
                _selectedDate == null
                    ? 'Выберите дату'
                    : 'Дата: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
              ),
            ),
            TextButton(
              onPressed: _selectTime,
              child: Text(
                _selectedTime == null
                    ? 'Выберите время'
                    : 'Время: ${_selectedTime!.format(context)}',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: null,
              decoration: InputDecoration(labelText: 'Описание события'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty && _selectedDate != null && _selectedTime != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventAdditionalDetailsScreen(
                        eventType: widget.eventType,
                        name: _nameController.text,
                        date: _selectedDate!,
                        time: _selectedTime!,
                        description: _descriptionController.text,
                      ),
                    ),
                  );
                }
              },
              child: const Text('Далее'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }
}
