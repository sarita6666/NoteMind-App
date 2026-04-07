class NoteModel {
  String id;
  String title;
  String content;
  String userId;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "content": content,
      "userId": userId,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map, String id) {
    return NoteModel(
      id: id,
      title: map["title"],
      content: map["content"],
      userId: map["userId"],
    );
  }
}