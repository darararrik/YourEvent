import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class chooseAgentcy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Список агентств'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('agents').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Ошибка: ${snapshot.error}'),
            );
          }
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return Center(
              child: Text('Агентства не найдены'),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final String agencyId = docs[index].id;
              final String agencyName = data['name'] ?? '';
              final String city = data['city'] ?? '';
              final String rating = data['rating']?.toString() ?? '';
              final String imageURL = data['imageURL'] ?? '';

              return Card(

                child: ListTile(
                  leading: imageURL.isNotEmpty
                      ? Image.network(
                    imageURL,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ): Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey,
                  ),
                  title: Text(agencyName),
                  subtitle: Text('Рейтинг: $rating\nГород: $city'),
                  onTap: () {
                    // Здесь можно добавить действие при нажатии на карточку агентства
                    // Например, открытие подробной информации об агентстве
                    // или навигацию на другой экран для редактирования/удаления агентства
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
