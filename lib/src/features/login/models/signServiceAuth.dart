import 'package:empreendedorismodigital2/src/features/login/models/siginServiceInterface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SiginServiceAuth implements SiginServiceInterface {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> signUser(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      return false;
    }
  }
}