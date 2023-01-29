import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empreendedorismodigital2/src/features/register/models/registerServiceInterface.dart';
import 'package:flutter/cupertino.dart';

class RegisterService implements RegisterServiceInterface
{
  final _fireStore = FirebaseFirestore.instance;

  @override
  void registerUser(String name, String email, String password) async {
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