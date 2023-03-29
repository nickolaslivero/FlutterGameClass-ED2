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

  Future<List<Map<String, String>>> getClasses(String id) async {
    // currentUser!.uid
    final docrefUser = FirebaseFirestore.instance.collection('users').doc(id);
    final snapshotUser = await docrefUser.get();

    if (snapshotUser.exists) {
      final List<dynamic> arrayField = snapshotUser.get('classes');
      final List<String> classesId = List<String>.from(arrayField);
      List<Map<String, String>> dictList = [];
      for (int i = 0; i < classesId.length; i++) {
        var docrefClass = FirebaseFirestore.instance.collection('classes').doc(classesId[i]);
        var snapshotClass = await docrefClass.get();
        String className = snapshotClass.get('name');
        String idProfessor = snapshotClass.get('idProfessor');
        String codeClass = snapshotClass.get('codeClass');
        var docrefProfessor = FirebaseFirestore.instance.collection('users').doc(idProfessor);
        var snapshotProfessor = await docrefProfessor.get();
        String professorName = snapshotProfessor.get('name');
        dictList.add({ 'classId': classesId[i], 'name': className, 'professorName': professorName, 'codeClass': codeClass });
      }
      return dictList;
    } else {
      throw Exception('Documento não encontrado!');
    }
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
