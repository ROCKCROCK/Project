import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitbuddy/page/bmicalculator.dart';
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

  String name = '';
  String imagesrc = '';

  Future<void> getUserdetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final uid = user.uid;
      print(uid);
      final DocumentSnapshot<Map<String, dynamic>> doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (doc.exists) {
        setState(() {
          name = doc.data()!['name'] ?? ''; // Use null-aware operator
          imagesrc = doc.data()!['image'] ?? ''; // Use null-aware operator
        });
      } else {
        print('Document does not exist');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserdetails();
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 196, 67, 110),
                  Color.fromARGB(255, 255, 123, 67)
                ],
              ),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'FitBuddy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: imagesrc.isNotEmpty
                              ? NetworkImage(imagesrc)
                              : AssetImage('assets/profile.png')
                                  as ImageProvider,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('BMI Calculator'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BMI_page()));
            },
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
        ],
      ),
    );
  }
}
