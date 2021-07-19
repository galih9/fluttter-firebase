import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({Key? key}) : super(key: key);

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              foregroundImage: NetworkImage(
                  'https://static.wikia.nocookie.net/megamitensei/images/2/28/Phantom_Thieves_Logo.png'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 9),
              child: Text('Kamu'),
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(),
            Row(
              children: [
                const Expanded(
                  child: TextField(
                    enableInteractiveSelection: false,
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 5.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 5.0),
                      ),
                      hintText: 'Chat here',
                    ),
                  ),
                ),
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
                      onPressed: () {},
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
