import 'package:empreendedorismodigital2/src/features/home/homeScreen.dart';
import 'package:empreendedorismodigital2/src/features/login/login.dart';
import 'package:empreendedorismodigital2/src/shared/user/userService2.dart';
import 'package:flutter/material.dart';

// FIREBASE PACKAGES
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const MaterialColor customBlack = MaterialColor(0xFF232323, {
    50: Color(0xFF4C4C4C),
    100: Color(0xFF3F3F3F),
    200: Color(0xFF333333),
    300: Color(0xFF272727),
    400: Color(0xFF1B1B1B),
    500: Color(0xFF0E0E0E),
    600: Color(0xFF0B0B0B),
    700: Color(0xFF080808),
    800: Color(0xFF050505),
    900: Color(0xFF020202),
  });

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GameClass',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: customBlack,
        ),
        home: const LoginScreen());
  }
}