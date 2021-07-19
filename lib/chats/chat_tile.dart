import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/chats/chat_room.dart';

class ChatTile extends StatelessWidget {
  final Color textUnreadGreenColor = const Color.fromARGB(255, 8, 211, 111);

  const ChatTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoomPage(),
            ),
          );
        },
        leading: const CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(
              'https://static.wikia.nocookie.net/megamitensei/images/2/28/Phantom_Thieves_Logo.png'),
        ),
        title: const Text(
          'kamu',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
        subtitle: const Text(
          'Hey duude',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // buildUnreadMessages(),
            containerText(),
            buildTextTime()
          ],
        ),
      ),
    );
  }

  Widget containerText() {
    return Container(height: 25, width: 25);
  }

  Widget buildUnreadMessages() {
    return Container(
      alignment: Alignment.center,
      height: 25,
      width: 25,
      decoration: BoxDecoration(
        color: textUnreadGreenColor,
        shape: BoxShape.circle,
      ),
      child: const Text(
        '12',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildTextTime() {
    return const Text(
      '10.20',
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }
}
