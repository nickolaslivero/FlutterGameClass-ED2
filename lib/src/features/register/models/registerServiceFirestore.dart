import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empreendedorismodigital2/src/features/register/models/registerServiceInterface.dart';
import 'package:flutter/cupertino.dart';

class RegisterController implements RegisterControllerInterface
{
  final _fireStore = FirebaseFirestore.instance;

  @override
  void registerUser(String name, String email, String password) async {
    /*
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
    */
    try {
      final docUser = _fireStore.collection('users').doc();
      final json = {
        'name': name,
        'email': email,
        'password': password,
      };
      await docUser.set(json);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}