// lib/chatbot.dart

import 'package:flutter/material.dart';
import 'dart:async';
import 'responses.dart'; // Assuming you have this file from the previous step

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  Future<void> sendMessage(String text) async {
    // 1. Add user message
    setState(() {
      _messages.add({'role': 'user', 'content': text});
      _isLoading = true;
    });

    // 2. Get the response from the local rule-based engine
    final reply = getRuleBasedResponse(text);

    // 3. Simulate processing time
    await Future.delayed(const Duration(milliseconds: 500));

    // 4. Add the assistant's response
    setState(() {
      _messages.add({'role': 'assistant', 'content': reply});
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mediscan Chatbot")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message['role'] == 'user'
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message['role'] == 'user'
                            ? Colors.blue[100]
                            : Colors.green[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(message['content'] ?? ""),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading) const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "Ask a question..."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      sendMessage(_controller.text);
                      _controller.clear();
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}