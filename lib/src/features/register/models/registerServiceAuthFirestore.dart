import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empreendedorismodigital2/src/features/register/models/registerServiceInterface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterServiceAuthFirestore implements RegisterServiceInterface {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  @override
  void registerUser(String name, String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final user = _fireStore.collection('users').doc(userCredential.user?.uid);
      final json = {
        'name': name,
        'email':email,
        'password': password,
      };
      await user.set(json);
    } catch (e) {
      // TODO
    }
  }
}