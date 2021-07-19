import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/chats/chat_tile.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [ChatTile(), ChatTile(), ChatTile()],
    );
  }
}
