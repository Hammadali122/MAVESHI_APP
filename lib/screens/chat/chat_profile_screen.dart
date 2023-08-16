import 'package:flutter/material.dart';
import 'package:maveshi/utils/colors.dart';

class ChatProfileScreen extends StatefulWidget {
  const ChatProfileScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ChatProfileScreenState createState() => _ChatProfileScreenState();
}

class _ChatProfileScreenState extends State<ChatProfileScreen> {
  final List<Message> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          const Divider(height: 1),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildMessage(Message message) {
    final isMe = message.senderId == 'me';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isMe ? AppColour.primaryColor : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          message.text,
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: AppColour.primaryColor,
            ),
            onPressed: () {
              final text = _textEditingController.text.trim();
              if (text.isNotEmpty) {
                setState(() {
                  _messages.add(Message(text: text, senderId: 'me'));
                  _messages.add(
                      Message(text: 'Example response', senderId: 'other'));
                });
                _textEditingController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final String senderId;

  Message({required this.text, required this.senderId});
}
