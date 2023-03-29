import 'package:flutter/material.dart';
import '../../shared/user/userService2.dart';
import '../editProfile/editProfileScreen.dart';

final AuthService authService = AuthService();

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void _refreshProfileScreen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            onPressed: () {
              _refreshProfileScreen();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
            const SizedBox(height: 16),
            FutureBuilder<String?>(
              future: authService.getUsername(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Erro ao buscar nome de usuário');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              authService.getEmail() ?? "",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()));
              },
              child: const Text('Editar perfil'),
            ),
          ],
        ),
      ),
    );
  }
}
