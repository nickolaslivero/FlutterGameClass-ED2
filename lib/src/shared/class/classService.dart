import 'package:cloud_firestore/cloud_firestore.dart';

class ClassService {
  Future<List<Map<String, String>>> getMessages(String classId) async {
    final classesRef = FirebaseFirestore.instance.collection('classes').doc(classId).collection('messages');
    final snapshot = await classesRef.get();
    final List<QueryDocumentSnapshot> documents = snapshot.docs;
    List<Map<String, String>> dictList = [];
    for (var document in documents) {
      String content = document.get('content');
      String idSender = document.get('idSender');
      var docrefSender = FirebaseFirestore.instance.collection('users').doc(idSender);
      var snapshotSender = await docrefSender.get();
      String senderName = snapshotSender.get('name');
      dictList.add({ 'idMessage': document.id, 'idSender': idSender, 'sender': senderName, 'content': content });
    }
    return dictList;
  }
}