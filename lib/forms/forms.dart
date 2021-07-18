import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddForm extends StatefulWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  CollectionReference todos = FirebaseFirestore.instance.collection("todos");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add user"),
          actions: [
            TextButton(
              onPressed: () {
                todos.add({'nama': textController.text}).whenComplete(() {
                  textController.text = "";
                  Navigator.pop(context);
                });
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter a name'),
            ),
          ),
        ));
  }
}
