import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/chats/chat_message.dart';

class ChatRoomPage extends StatefulWidget {
  final String roomTitle;
  final String photoUrl;
  final String roomId;

  const ChatRoomPage(
      {Key? key,
      required this.roomTitle,
      required this.photoUrl,
      required this.roomId})
      : super(key: key);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final chatController = TextEditingController();
  late CollectionReference message;
  final user = FirebaseAuth.instance.currentUser;
  DateTime currentDate = DateTime.now(); //DateTime
  late Timestamp resTimestamp;
  @override
  void initState() {
    super.initState();
    message = FirebaseFirestore.instance
        .collection("message")
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
              foregroundImage: NetworkImage(widget.photoUrl),
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
                        message.add({
                          'messageText': chatController.text,
                          'sentAt': resTimestamp,
                          'sentBy': user!.uid
                        }).whenComplete(() {
                          chatController.text = "";
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
