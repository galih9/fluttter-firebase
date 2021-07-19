import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/chats/chat_homepage.dart';
import 'package:flutter_blog_gg/screens/profile.dart';
import 'package:flutter_blog_gg/tasks/tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  CollectionReference users = FirebaseFirestore.instance.collection("users");

  @override
  void initState() {
    super.initState();
    if (currentUser!.metadata.creationTime ==
        currentUser!.metadata.lastSignInTime) {
      registerNewAccount();
    }
  }

  Future registerNewAccount() async {
    try {
      await users.doc(currentUser!.uid).set({
        'name': currentUser!.displayName,
        'photo': currentUser!.photoURL,
        'email': currentUser!.email,
      }).whenComplete(() {
        debugPrint('added');
      });
    } catch (e) {
      debugPrint('err' + e.toString());
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  final List<Widget> _widgetOptions = <Widget>[
    ChatHomePage(),
    const TasksPage(),
    const Text(
      'Index 2: Map',
      style: optionStyle,
    ),
    const Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple User Manager"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            child: const Text(
              "Profile",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: "Task",
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Map",
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings",
              backgroundColor: Colors.blue),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
