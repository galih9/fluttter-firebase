import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_gg/provider/sign_in.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          TextButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogout().whenComplete(() {
                Navigator.pop(context);
              });
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(children: [
          const Text("Your profile"),
          const SizedBox(
            height: 32,
          ),
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user!.photoURL!),
          ),
          Text(user!.displayName!),
          Text(user!.email!),
          Text(user!.emailVerified.toString()),
        ]),
      ),
    );
  }
}
