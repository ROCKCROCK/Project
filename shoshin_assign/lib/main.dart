import 'package:flutter/material.dart';
import 'package:shoshin_assign/page/dashboard.dart';

void main() async {
  runApp(shoshin_assign());
}

class shoshin_assign extends StatelessWidget {
  const shoshin_assign({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'shoshin_assign',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const dashboard_page(),
    );
  }
}
