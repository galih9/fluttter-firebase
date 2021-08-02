import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNewRoom extends StatefulWidget {
  AddNewRoom({Key? key}) : super(key: key);

  @override
  _AddNewRoomState createState() => _AddNewRoomState();
}

class _AddNewRoomState extends State<AddNewRoom> {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  CollectionReference groups = FirebaseFirestore.instance.collection("group");
  CollectionReference chats = FirebaseFirestore.instance.collection("chat");

  final titleController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  late Timestamp resTimestamp;
  DateTime currentDate = DateTime.now(); //DateTime

  @override
  void initState() {
    super.initState();
    resTimestamp = Timestamp.fromDate(currentDate); //To TimeStamp
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new room'),
      ),
      body: StreamBuilder(
          stream: users.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text("Loading ..."));
            } else if (snapshot.data!.size == 0) {
              return const Center(
                child: Text('No users here :D'),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((e) {
                if (e['email'] != user!.email!) {
                  return ListTile(
                    title: Text(e['name']),
                    subtitle: Text(e['email']),
                    onTap: () {
                      var messageId = chats.doc().id;
                      var btn = false;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Insert room name'),
                          content: TextField(
                            controller: titleController,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Cancel');
                                titleController.text = '';
                                btn = false;
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'Ok');
                                groups.add({
                                  'createdAt': resTimestamp,
                                  'createdBy': user!.uid,
                                  'groupIcon': '',
                                  'groupTitle': titleController.text,
                                  'id': messageId,
                                  'members': [user!.uid, e.id],
                                  'recentMessage': {
                                    'messageText': '',
                                    'readBy': {
                                      'sentAt': resTimestamp,
                                      'sentBy': user!.uid
                                    }
                                  },
                                  'type': 1
                                }).whenComplete(() {
                                  chats
                                      .doc(messageId)
                                      .set({'check': 'check'}).whenComplete(() {
                                    Navigator.pop(context);
                                  });
                                });
                                titleController.text = '';
                                btn = true;
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ).whenComplete(() {
                        if (btn) {
                          Navigator.pop(context);
                        }
                      });
                    },
                  );
                } else {
                  return const SizedBox();
                }
              }).toList(),
            );
          }),
    );
  }
}
