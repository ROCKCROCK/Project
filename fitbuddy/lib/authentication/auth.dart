import 'package:firebase_auth/firebase_auth.dart';
//import 'package:fitbuddy/page/login.dart';
import 'package:fitbuddy/page/workout_page.dart';
import 'package:flutter/material.dart';
import 'package:fitbuddy/authentication/authpage.dart';

class auth_page extends StatelessWidget {
  const auth_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return workoutPage();
            } else {
              return authp();
            }
          }),
    );
  }
}
