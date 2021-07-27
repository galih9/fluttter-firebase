import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/chats/forms/new_room.dart';
import 'chat_tile.dart';
import 'package:sizer/sizer.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  CollectionReference groups = FirebaseFirestore.instance.collection("group");
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // getGroupChat();
  }

  getGroupChat() async {
    var test = await groups.where('members', arrayContains: user!.uid).get();
    debugPrint(test.toString() + "test");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: groups.where('members', arrayContains: user!.uid).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text("Loading ..."));
        } else if (snapshot.data!.size == 0) {
          return Stack(
            fit: StackFit.expand,
            children: [
              const Center(
                child: Text(
                    'you have no chat :( \n create a new chat right now \n by clicking the plus button'),
              ),
              Positioned(
                right: 2.h,
                bottom: 2.h,
                child: FloatingActionButton(
                  heroTag: 'add',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddNewRoom(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          );
        }
        return Stack(
          fit: StackFit.expand,
          children: [
            ListView(
              children: snapshot.data!.docs.map((e) {
                return ChatTile(
                  roomId: e['id'],
                  recentMessage: e['recentMessage']['messageText'],
                  roomTitle: e['groupTitle'],
                  groupId: e.id,
                  photoUrl: e['groupIcon'],
                  lastSent: e['recentMessage']['readBy']['sentAt'],
                );
              }).toList(),
            ),
            Positioned(
              right: 2.h,
              bottom: 2.h,
              child: FloatingActionButton(
                heroTag: 'add',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddNewRoom(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          ],
        );
      },
    );
  }
}
