import 'package:YourEvent/screens/authPage.dart';
import 'package:flutter/material.dart';
import 'package:YourEvent/firebase_service.dart';

import '../design/colors.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String? _username;
  late String? _email;
  late String? _photoUrl;
  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseService()
        .currentUser; // Если пользователь авторизован, отображаем профиль
    _username = currentUser?.displayName; // Имя пользователя
     _email = currentUser?.email; // Электронная почта пользователя
    _photoUrl = currentUser?.photoURL; // URL фото профиля пользователя
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Профиль пользователя',style: TextStyle(fontSize: 24),),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 32,
              color: primaryContainer,
            ),
            onPressed: () {
              FirebaseService().logOut();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: _photoUrl != null
                  ? NetworkImage(_photoUrl!)
                  : const AssetImage(
                  'assets/default_avatar.png') as ImageProvider,
            ),
            const SizedBox(height: 20),
            const Text(
              'Имя пользователя:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              _username ?? 'Не указано',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              'Электронная почта:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              _email ?? 'Не указано',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
