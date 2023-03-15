import 'package:flutter/material.dart';
import '../../shared/user/userService2.dart';
import '../editProfile/editProfileScreen.dart';


final AuthService authService = AuthService();

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  );
                } else if (snapshot.hasError) {
                  return Text('Erro ao buscar nome de usuário');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(height: 8),
            Text(
              authService.getEmail() ?? "",
              style: TextStyle(fontSize: 16),
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
