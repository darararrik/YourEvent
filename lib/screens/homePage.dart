import 'package:YourEvent/screens/createEventPage/EventTypeSelectionPage.dart';
import 'package:YourEvent/screens/myEvents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/cardAgent.dart';
import '/screens/profilePage.dart';
import '../widgets/customIconButton.dart';
import '/design/colors.dart';
import 'AgentcyPage.dart';
import 'package:YourEvent/firebase_service.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePage();
}


class _HomePage extends State<HomePage> {
  int currentPageIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    chooseAgentcy(),
    MyEvents(),
    ProfilePage(),

  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:_widgetOptions[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index)
        {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: primaryContainer,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_outlined,color: Colors.white,size: 32,),
            icon: Icon(Icons.home_outlined,color: secondaryGray,size: 32,),
            label: 'Главная',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.filter_none_outlined,color: Colors.white,),
            icon: Icon(Icons.filter_none_outlined,color: secondaryGray),
            label: 'Агентства',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.calendar_month_outlined, color: Colors.white,),
            icon: Icon(Icons.calendar_month_outlined,color: secondaryGray,),
            label: 'Мои события',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person_outlined, color: Colors.white,),
            icon: Icon(Icons.person_outlined,color: secondaryGray,),
            label: 'Профиль',
          ),
        ],

      ),
    );


  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  final _db = FirebaseService().getFirestoreInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная', style: TextStyle(fontSize: 24)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              size: 32,
              color: primaryContainer,
            ),
            onPressed: () {
              print('Я КНОПКА');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Хотите организовать мероприятие?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Выберите способ организации',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomIconButton(
                  text: 'Выбрать агентство\nмероприятий',
                  imagePath: "assets/images/pic.png",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => chooseAgentcy()),
                    );
                  },
                ),
                const SizedBox(width: 60),
                CustomIconButton(
                  text: 'Нет, спасибо,\nорганизую сам',
                  imagePath: "assets/images/pic2.png",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventTypeSelectionScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 64),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Лучшие ивент-агенства',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 220, // Уменьшенная высота горизонтального списка
              child: StreamBuilder<QuerySnapshot>(
                stream: _db.collection('agents').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('Нет доступных событий'));
                  }

                  final agents = snapshot.data!.docs;

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: agents.length,
                    itemBuilder: (context, index) {
                      final agent = agents[index];
                      final data = agent.data() as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: AgentCard(
                        name: data['name'] ?? 'Без названия',
                        city: data['city'] ?? '',
                        rating: data['rating'],
                        imageUrl: data['imageURL'],
                      ),);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




