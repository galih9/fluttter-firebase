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
  final user = FirebaseAuth.instance.currentUser;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    chatData = FirebaseFirestore.instance
        .collection("chat")
        .doc(widget.roomId)
        .collection('messages');
    debugPrint(widget.roomId);
    final user = FirebaseAuth.instance.currentUser;
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
          }
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOut);
            }
          });

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs.map((e) {
              if (e['sentBy'] != user!.uid) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Stack(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e['senderDisplayName']),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, left: 8, right: 8, bottom: 8),
                          child: Text(
                            e['messageText'],
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          e['messageText'],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );
              }
            }).toList(),
          );
        },
      ),
    );
  }
}
