import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = "chat_comunitario";


  Future<void> sendMessage(String text) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("Usuario no autenticado");

    final messageData = {
      'senderId': user.uid,
      'senderName': user.displayName ?? user.email ?? "Usuario",
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await _firestore.collection(collectionPath).add(messageData);
  }

  Stream<List<Map<String, dynamic>>> getMessagesStream() {
    return _firestore
        .collection(collectionPath)
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return {
                'id': doc.id,
                'senderName': data['senderName'] ?? "Usuario",
                'text': data['text'] ?? "",
                'timestamp': data['timestamp'],
              };
            }).toList());
  }
}