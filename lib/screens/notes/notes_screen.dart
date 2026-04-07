import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/note_model.dart';
import '../../services/note_service.dart';

class NotesScreen extends StatelessWidget {
  final NoteService _noteService = NoteService();
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  NotesScreen({super.key});

  void _createNote(BuildContext context) async {
    await _noteService.create(
      NoteModel(
        id: "",
        title: "Nueva nota",
        content: "Contenido...",
        userId: userId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Notas"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNote(context),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<NoteModel>>(
        stream: _noteService.getNotes(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notes = snapshot.data!;

          if (notes.isEmpty) {
            return const Center(child: Text("No hay notas"));
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (_, index) {
              final note = notes[index];

              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _noteService.delete(note.id),
                ),
              );
            },
          );
        },
      ),
    );
  }
}