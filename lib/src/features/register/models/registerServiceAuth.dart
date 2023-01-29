import 'package:empreendedorismodigital2/src/features/register/models/registerServiceInterface.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterService implements RegisterServiceInterface
{
  @override
  void registerUser(String name, String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account exists got that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}