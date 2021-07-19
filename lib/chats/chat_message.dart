import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatMessages extends StatefulWidget {
  final String roomId;
  const ChatMessages({Key? key, required this.roomId}) : super(key: key);

  @override
  State<ChatMessages> createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  late CollectionReference chatData;

  @override
  void initState() {
    super.initState();
    chatData = FirebaseFirestore.instance
        .collection("message")
        .doc(widget.roomId)
        .collection('messages');
    final user = FirebaseAuth.instance.currentUser;
    debugPrint(widget.roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h, top: 1.h, right: 1.h, bottom: 10.h),
      child: StreamBuilder(
        stream: chatData.orderBy('sentAt', descending: false).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("Loading ..."));
          } else if (snapshot.data!.size == 0) {
            return const Center(
              child: Text('No chat here :D'),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((e) {
              return ListTile(
                title: Text(e['messageText']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
