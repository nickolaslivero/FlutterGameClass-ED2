import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Retorna o usuário atualmente logado
  User? get currentUser => _auth.currentUser;

  // Retorna o nome de usuário do usuário atualmente logado
  Future<String?> getUsername() async {
    final user = _auth.currentUser;
    if (user == null) {
      return null;
    }

    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    return snapshot.get('name');
  }

  // Retorna o email do usuário atualmente logado
  String? getEmail() {
    final user = _auth.currentUser;
    return user?.email;
  }

  void setUserName(String newUserName) async {
    final user = _auth.currentUser;
    String? userUid = user?.uid;
    String? email = user?.email;
    final userFirestore = FirebaseFirestore.instance.collection('users').doc(userUid);
    final json = {
      'name': newUserName,
      'email': email,
      'uid': userUid,
    };
    await userFirestore.set(json);
  }
}
