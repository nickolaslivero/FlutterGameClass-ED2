import 'package:flutter/material.dart';
import '../../shared/user/userService2.dart';
import '../login/login.dart';
import '../profile/profileScreen.dart';
import '../settings/settingsScreen.dart';

final _service = AuthService();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  //Future<Map<String, Map<String, String>>> dict = _service.getClasses();

  final List<Widget> _children = [
    const HomeTab(),
    const SearchTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage('assets/avatar.png'),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tasks',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.black87),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white, // Define a cor do texto como branco
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Perfil'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
            ),
            ListTile(
              title: const Text('Configurações'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()));
              },
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                // Logout code here
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClassCard(
            title: 'Matemática',
            subtitle: 'Você não possui tarefas pendentes.'),
        ClassCard(
            title: 'Empreendedorismo',
            subtitle: 'Você não possui tarefas pendentes.'),
        ClassCard(
            title: 'Programação',
            subtitle: 'Você não possui tarefas pendentes.'),
        //MyListView()
      ],
    );
  }
}

class ClassCard extends StatelessWidget {
  const ClassCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black12,
      child: Column(
        children: [
          ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
          ),
        ],
      ),
    );
  }
}

class SearchTab extends StatelessWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Store Tap'),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Task Tab'),
    );
  }
}

class MyListView extends StatelessWidget {
  Future<List<Map<String, String>>> dictList = _service.getClasses();

  MyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Container> containers = [];
    dictList.then((list) {
      int length = list.length;
      for (int i = 0; i < length; i++) {
        containers.add(
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.blue,
            child: Text(list[i]['name'] ?? ''),
          ),
        );
      }
    });

    return ListView.builder(
      itemCount: containers.length,
      itemBuilder: (context, index) {
        return containers[index];
      },
    );
  }
}
