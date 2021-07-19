import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditForm extends StatefulWidget {
  const EditForm({Key? key, required this.ogName, required this.docId})
      : super(key: key);
  final String ogName;
  final String docId;

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  var textController = TextEditingController();
  CollectionReference todos = FirebaseFirestore.instance.collection("todos");

  @override
  void initState() {
    super.initState();
    textController.text = widget.ogName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update user"),
        actions: [
          TextButton(
            onPressed: () {
              if (textController.text == widget.ogName) {
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (_) => AlertDialog(
                    title: const Text("Are you sure want to update this data?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          todos.doc(widget.docId).update(
                              {"nama": textController.text}).whenComplete(() {
                            textController.text = "";
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No"),
                      ),
                    ],
                  ),
                ).whenComplete(() {
                  Navigator.pop(context);
                });
              }
            },
            child: const Text(
              "Update",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
        child: TextField(
          controller: textController,
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'Enter a name'),
        ),
      ),
    );
  }
}
