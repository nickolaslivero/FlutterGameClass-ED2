import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final _firebaseAuth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  User? getUser() {
    return _firebaseAuth.currentUser;
  }

  String? getUserEmail() {
    return _firebaseAuth.currentUser?.email;
  }

  String? getUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  String? getUserName() {
    String? userName;
    String? userUid = getUserId();
    users.doc(userUid).get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      userName = data['name'];
    });
    return userName;
  }

  void setUserName(String newUserName) async {
    String? userUid = getUserId();
    String? email = getUserEmail();
    final user = users.doc(userUid);
    final json = {
      'name': newUserName,
      'email': email,
      'uid': userUid,
    };
    await user.set(json);
  }
}