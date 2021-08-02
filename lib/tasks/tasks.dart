import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/forms/forms.dart';
import 'package:flutter_blog_gg/forms/forms_edit.dart';
import 'package:flutter_blog_gg/forms/search_form.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:sizer/sizer.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  CollectionReference todos = FirebaseFirestore.instance.collection("todos");

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              height: 24.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: connected
                    ? const Color(0xFF00EE44)
                    : const Color(0xFFEE4400),
                child: Center(
                  child: Text(connected ? 'ONLINE' : 'OFFLINE'),
                ),
              ),
            ),
            Center(
              child: StreamBuilder(
                stream: todos.orderBy("nama").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text("Loading ..."));
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ListView(
                      children: snapshot.data!.docs.map((e) {
                        return Center(
                          child: ListTile(
                            title: Text(e['nama']),
                            trailing: Wrap(
                              children: <Widget>[
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditForm(
                                            ogName: e['nama'],
                                            docId: e.id,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.info)), // icon-1
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditForm(
                                            ogName: e['nama'],
                                            docId: e.id,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit)), // icon-1
                                IconButton(
                                    onPressed: () {
                                      todos.doc(e.id).delete();
                                    },
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
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
                      builder: (context) => const AddForm(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
            Positioned(
              right: 10.h,
              bottom: 2.h,
              child: FloatingActionButton(
                heroTag: 'search',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchForm(),
                    ),
                  );
                },
                child: const Icon(Icons.search),
              ),
            )
          ],
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'There are no bottons to push :)',
          ),
          Text(
            'Just turn off your internet.',
          ),
        ],
      ),
    );
  }
}
