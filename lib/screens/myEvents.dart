import 'package:YourEvent/design/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:YourEvent/models/event.dart'; // Импортируйте ваш класс Event

class MyEvents extends StatefulWidget {
  const MyEvents({super.key});

  @override
  State<MyEvents> createState() => _MyEventsState();
}

class _MyEventsState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Мои события"),
          bottom: const TabBar(
            labelColor: primaryContainer,
            indicatorColor: primaryContainer,

            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.event_note,),
                    SizedBox(width: 8),
                    Text('Созданные'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.done_all),
                    SizedBox(width: 8),
                    Text('Выполненные'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildEventList(false),
            _buildEventList(true),
          ],
        ),
      ),
    );
  }

  Widget _buildEventList(bool isCompleted) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(child: Text('Необходимо войти в систему'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('events')
          .where('uid', isEqualTo: user.uid)
          .where('isCompleted', isEqualTo: isCompleted)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Ошибка: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Нет событий'));
        }

        final events = snapshot.data!.docs.map((doc) {
          return Event.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();

        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            return ListTile(
              title: Text(event.name),
              subtitle: Text(event.description),
              trailing: isCompleted
                  ? Icon(Icons.check_circle, color: Colors.green)
                  : Icon(Icons.pending, color: Colors.grey),
            );
          },
        );
      },
    );
  }
}
