import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/forms/forms.dart';
import 'package:flutter_blog_gg/forms/forms_edit.dart';
import 'package:flutter_blog_gg/forms/search_form.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference users = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
      ),
      body: OfflineBuilder(
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
                  stream: users.orderBy("nama").snapshots(),
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
                  },
                ),
              ),
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
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22),
        visible: true,
        curve: Curves.bounceIn,
        children: [
          // FAB 1
          SpeedDialChild(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddForm(),
                ),
              );
            },
            foregroundColor: ThemeData().secondaryHeaderColor,
            backgroundColor: ThemeData().primaryColor,
            label: 'Add Task',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: ThemeData().secondaryHeaderColor,
                fontSize: 16.0),
            labelBackgroundColor: ThemeData().primaryColor,
          ),
          // FAB 2
          SpeedDialChild(
            child: const Icon(Icons.search),
            foregroundColor: ThemeData().secondaryHeaderColor,
            backgroundColor: ThemeData().primaryColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchForm(),
                ),
              );
            },
            label: 'Search task',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: ThemeData().secondaryHeaderColor,
                fontSize: 16.0),
            labelBackgroundColor: ThemeData().primaryColor,
          )
        ],
      ),
    );
  }
}
