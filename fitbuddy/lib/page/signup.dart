import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:fitbuddy/page/login.dart';
import 'package:flutter/material.dart';
import 'package:fitbuddy/my_flutter_app_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';

class signup extends StatefulWidget {
  final VoidCallback showloginpage;
  const signup({super.key, required this.showloginpage});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final userNamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final weightcontroller = TextEditingController();
  final heightcontroller = TextEditingController();
  final imagePicker = ImagePicker();
  String imageURL = '';

  void signUserup() async {
    // if (passwordcontroller.text.isEmpty) {
    // Show an error message or handle the case where email or password is empty.
    //   print('Email or password is empty');
    // } else {
    //   print('Email or password is not empty');
    // }
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text, password: passwordcontroller.text);
      addUserdetails(
        userNamecontroller.text.trim(),
        emailcontroller.text.trim(),
        int.parse(weightcontroller.text.trim()),
        int.parse(heightcontroller.text.trim()),
        imageURL,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        weakPasswordmessage();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        emailAlreadyInUse();
        print('The account already exists for that email.');
      }
    }
  }

  void emailAlreadyInUse() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Email already in use'),
            content: const Text('Please enter a different email'),
            actions: [
              TextButton(
                  onPressed: () {
                    emailcontroller.clear();
                    passwordcontroller.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  void weakPasswordmessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Weak Password'),
            content: const Text('Please enter a strong password'),
            actions: [
              TextButton(
                  onPressed: () {
                    emailcontroller.clear();
                    passwordcontroller.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  Future addUserdetails(
      String name, String email, int weight, int height, String? image) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'email': email,
      'weight': weight,
      'height': height,
      if (image != null) 'image': image,
    });
  }

  void pickImage() async {
    XFile? File = await imagePicker.pickImage(source: ImageSource.gallery);
    if (File != null) {
      uploadImage(File);
    } else {
      return;
    }
  }

  void uploadImage(XFile file) async {
    String imageURLdum = '';
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference fileRef = referenceRoot.child('profile images');
    String fileName = file.name;
    Reference imageRef = fileRef.child('$fileName');

    try {
      await imageRef.putFile(File(file!.path));
      imageURLdum = await imageRef.getDownloadURL();
      setState(() {
        imageURL = imageURLdum;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 196, 67, 110),
                  Color.fromARGB(255, 255, 123, 67)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 90),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: imageURL.isNotEmpty
                        ? NetworkImage(imageURL)
                        : AssetImage('assets/profile.png') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: -10,
                    child: IconButton(
                      onPressed: () async {
                        Map<Permission, PermissionStatus> statuses =
                            await [Permission.storage].request();
                        if (statuses[Permission.storage]!.isGranted) {
                          pickImage();
                        }
                      },
                      icon: const Icon(Icons.add_a_photo),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  labelText: 'Name',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                controller: userNamecontroller,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                controller: emailcontroller,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                controller: passwordcontroller,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  icon: const Icon(
                    MyFlutterApp.weight,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  labelText: 'Weight',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                controller: weightcontroller,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  icon: const Icon(
                    MyFlutterApp.accessibility,
                    color: Colors.white,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  labelText: 'Height',
                  labelStyle: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                controller: heightcontroller,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: signUserup,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      'Sign Up')),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                      onPressed: widget.showloginpage,
                      child: const Text(
                        'Log in!',
                        style: TextStyle(
                          color: Colors.teal,
                          fontSize: 20,
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
