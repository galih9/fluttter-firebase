import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  const SearchForm({Key? key}) : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final textController = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search Form"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Form(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        textController
                          ..text = val
                          ..selection = TextSelection.collapsed(
                              offset: textController.text.length);
                      });
                    },
                    controller: textController,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              textController.text = "";
                            },
                            icon: const Icon(Icons.clear)),
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search Here'),
                  ),
                ),
              ),
              StreamBuilder(
                  stream: (textController.text == "")
                      ? users.snapshots()
                      : users
                          .where("nama", arrayContains: textController.text)
                          .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text("Loading ..."));
                    } else if (textController.text != "") {
                      return Padding(
                        padding: const EdgeInsets.only(top: 70),
                        child: ListView(
                          children: snapshot.data!.docs.map((e) {
                            return Center(
                              child: ListTile(
                                title: Text(e['nama']),
                                trailing: Wrap(
                                  children: <Widget>[
                                    IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.edit)), // icon-1
                                    IconButton(
                                        onPressed: () {
                                          users.doc(e.id).delete();
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: ListView(
                        children: snapshot.data!.docs.map((e) {
                          return Center(
                            child: ListTile(
                              title: Text(e['nama']),
                              trailing: Wrap(
                                children: <Widget>[
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit)), // icon-1
                                  IconButton(
                                      onPressed: () {
                                        users.doc(e.id).delete();
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}
