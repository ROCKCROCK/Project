import 'package:fitbuddy/page/login.dart';
import 'package:fitbuddy/page/signup.dart';
import 'package:flutter/material.dart';

class authp extends StatefulWidget {
  const authp({super.key});

  @override
  State<authp> createState() => _authpState();
}

class _authpState extends State<authp> {
  bool isloggedin = true;
  void togglescreen() {
    setState(() {
      isloggedin = !isloggedin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isloggedin) {
      return login(showsignuppage: togglescreen);
    } else {
      return signup(
        showloginpage: togglescreen,
      );
    }
  }
}
