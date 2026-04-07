import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class NoteService {
  final _db = FirebaseFirestore.instance;

  Future<void> create(NoteModel note) async {
    await _db.collection("notes").add(note.toMap());
  }
  
  Stream<List<NoteModel>> getNotes(String userId) {
    return _db
        .collection("notes")
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NoteModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> delete(String id) async {
    await _db.collection("notes").doc(id).delete();
  }
}