import 'package:flutter/material.dart';

class dashboard_page extends StatefulWidget {
  const dashboard_page({super.key});

  @override
  State<dashboard_page> createState() => _dashboard_pageState();
}

class _dashboard_pageState extends State<dashboard_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {},
            ),
            const SizedBox(
                width: 8), // Adjust the spacing between icon and text
            const Text(
              'Hi User!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
