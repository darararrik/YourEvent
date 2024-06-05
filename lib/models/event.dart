import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String uid;
  final String name;
  final EventType type;
  final int numOfPeople;
  final DateTime date;
  final String description;
  final double budget;
  final bool isCompleted; // Новое поле

  Event({
    required this.uid,
    required this.name,
    required this.type,
    required this.numOfPeople,
    required this.date,
    required this.description,
    required this.budget,
    this.isCompleted = false, // Инициализация по умолчанию
  });

  factory Event.fromJson(Map<String, dynamic> json, String id) {
    return Event(
      uid: json['uid'],
      name: json['name'],
      type: EventType.values.firstWhere((type) => type.toString() == 'EventType.${json['type']}'),
      numOfPeople: json['numOfPeople'],
      date: (json['date'] as Timestamp).toDate(),
      description: json['description'],
      budget: (json['budget'] as num).toDouble(),
      isCompleted: json['isCompleted'] ?? false, // Дефолтное значение false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'type': type.toString().split('.').last, // Преобразуем enum в строку
      'numOfPeople': numOfPeople,
      'date': date,
      'description': description,
      'budget': budget,
      'isCompleted': isCompleted,
    };
  }
}
enum EventType {
  conference,
  wedding,
  birthday,
  workshop,
  concert,
  other
}

extension EventTypeExtension on EventType {
  String get displayName {
    switch (this) {
      case EventType.conference:
        return 'Конференция';
      case EventType.wedding:
        return 'Свадьба';
      case EventType.birthday:
        return 'День рождения';
      case EventType.workshop:
        return 'Мастер-класс';
      case EventType.concert:
        return 'Концерт';
      case EventType.other:
        return 'Другое';
      default:
        return '';
    }
  }
}
