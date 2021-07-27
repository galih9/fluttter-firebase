import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chat_room.dart';
import 'package:jiffy/jiffy.dart';

class ChatTile extends StatelessWidget {
  final Color textUnreadGreenColor = const Color.fromARGB(255, 8, 211, 111);

  final String recentMessage;
  final String roomTitle;
  final String photoUrl;
  final Timestamp lastSent;
  final String roomId;
  final String groupId;

  const ChatTile(
      {Key? key,
      required this.recentMessage,
      required this.roomTitle,
      required this.photoUrl,
      required this.lastSent,
      required this.groupId,
      required this.roomId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoomPage(
                roomTitle: roomTitle,
                photoUrl: photoUrl,
                groupId: groupId,
                roomId: roomId,
              ),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 30.0,
          backgroundColor: Colors.transparent,
          backgroundImage: photoUrl != ''
              ? NetworkImage(photoUrl)
              : const NetworkImage(
                  'https://image.freepik.com/free-vector/chat-bubble_53876-25540.jpg'),
        ),
        title: Text(
          roomTitle,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          recentMessage,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
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
    return Text(
      Jiffy(lastSent.toDate()).format('h.mm'),
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }
}
