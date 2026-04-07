import 'package:flutter/material.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatComunitarioScreen extends StatefulWidget {
  const ChatComunitarioScreen({super.key});

  @override
  State<ChatComunitarioScreen> createState() => _ChatComunitarioScreenState();
}

class _ChatComunitarioScreenState extends State<ChatComunitarioScreen> {
  final TextEditingController _controller = TextEditingController();
  final ChatService _chatService = ChatService();
  late final Stream<List<Map<String, dynamic>>> _messagesStream;
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _messagesStream = _chatService.getMessagesStream();
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    try {
      await _chatService.sendMessage(text);
      _controller.clear();
      FocusScope.of(context).unfocus();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al enviar mensaje: $e")),
      );
    }
  }

  Widget _buildMessageBubble(Map<String, dynamic> msg) {
    final isUser = msg['senderName'] ==
        (user?.displayName ?? user?.email ?? "");

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? Colors.purple : Colors.purple.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              msg['senderName'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: isUser ? Colors.white70 : Colors.purple.shade700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              msg['text'],
              style: TextStyle(
                color: isUser ? Colors.white : Colors.purple.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF7B2FF7),
                Color(0xFFF107A3),
              ],
            ),
          ),
        ),
        title: Row(
          children: const [
            Icon(Icons.auto_awesome, color: Colors.white),
            SizedBox(width: 8),
            Text(
              "NoteMine",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Chat Comunitario",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Comparte y conversa con otros estudiantes",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
              ),
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: _messagesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final messages = snapshot.data ?? [];

                  if (messages.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.chat_bubble_outline,
                            size: 60, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        const Text(
                          "No hay mensajes aún",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Sé el primero en iniciar la conversación",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  }

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (_, i) => _buildMessageBubble(messages[i]),
                  );
                },
              ),
            ),
          ),
Container(
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  padding: const EdgeInsets.symmetric(horizontal: 12),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)],
  ),
  child: Row(
    children: [
      Expanded(
        child: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: "Escribe un mensaje...",
            border: InputBorder.none,
          ),
          textInputAction: TextInputAction.send,

          /// 🔥 ENTER ENVÍA
          onSubmitted: (_) => _sendMessage(),
        ),
      ),

      /// 🔥 BOTÓN ENVIAR (LO RECUPERAMOS)
      IconButton(
        icon: const Icon(Icons.send, color: Colors.purple),
        onPressed: _sendMessage,
      ),
    ],
  ),
)
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(currentIndex: 1),
    );
  }
}