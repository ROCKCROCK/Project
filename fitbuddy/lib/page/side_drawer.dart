import 'package:firebase_auth/firebase_auth.dart';
//import 'package:fitbuddy/login.dart';
import 'package:flutter/material.dart';

class sidedrawer extends StatefulWidget {
  const sidedrawer({super.key});

  @override
  State<sidedrawer> createState() => _sidedrawerState();
}

class _sidedrawerState extends State<sidedrawer> {
  void signUserout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(30),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'FitBuddy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              signUserout();
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
