import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_message.dart';

class ChatRoomPage extends StatefulWidget {
  final String roomTitle;
  final String photoUrl;
  final String roomId;
  final String groupId;

  const ChatRoomPage(
      {Key? key,
      required this.roomTitle,
      required this.photoUrl,
      required this.groupId,
      required this.roomId})
      : super(key: key);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  CollectionReference groups = FirebaseFirestore.instance.collection("group");
  final chatController = TextEditingController();
  late CollectionReference message;
  final user = FirebaseAuth.instance.currentUser;
  DateTime currentDate = DateTime.now(); //DateTime
  late Timestamp resTimestamp;
  @override
  void initState() {
    super.initState();
    message = FirebaseFirestore.instance
        .collection("chat")
        .doc(widget.roomId)
        .collection('messages');
    debugPrint(widget.roomId);
    resTimestamp = Timestamp.fromDate(currentDate); //To TimeStamp
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundImage: widget.photoUrl != ''
                  ? NetworkImage(widget.photoUrl)
                  : const NetworkImage(
                      'https://image.freepik.com/free-vector/chat-bubble_53876-25540.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9),
              child: Text(widget.roomTitle),
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ChatMessages(
              roomId: widget.roomId,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chatController,
                    enableInteractiveSelection: false,
                    minLines: 1,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 5.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 5.0),
                      ),
                      hintText: 'Type here',
                    ),
                  ),
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  width: 50,
                  height: 50,
                  child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: const BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      onPressed: () {
                        var messageText = chatController.text;
                        chatController.text = "";
                        message.add({
                          'messageText': messageText,
                          'sentAt': resTimestamp,
                          'sentBy': user!.uid,
                          'senderDisplayName': user!.displayName
                        }).whenComplete(() {
                          groups.doc(widget.groupId).update({
                            'recentMessage': {
                              'messageText': messageText,
                              'readBy': {
                                'sentAt': resTimestamp,
                              }
                            }
                          });
                        });
                      },
                      child: const Icon(Icons.send)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
