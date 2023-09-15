import 'package:flutter/material.dart';
import 'list.dart';
import 'sections.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Sections> sectionList = Sections.sectionList();
  List<String> tempSectionNames = [];

  void updateMyTiles(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final Sections item = sectionList.removeAt(oldIndex);
      sectionList.insert(newIndex, item);
    });
  }

  void saveChanges() {
    setState(() {
      for (int i = 0; i < sectionList.length; i++) {
        Sections section = sectionList[i];
        if (section.isEditing ?? false) {
          section.isEditing = false;
        }
      }
    });
  }

  void exitEditing() {
    setState(() {
      for (Sections section in sectionList) {
        if (section.isEditing ?? false) {
          section.isEditing = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                      'Select Your sections',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 640,
                    child: ReorderableListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (int index = 0; index < sectionList.length; index++)
                          ListViewWidget(
                            section: sectionList[index],
                            key: ValueKey('${sectionList[index].id}'),
                          ),
                      ],
                      onReorder: (oldIndex, newIndex) =>
                          updateMyTiles(oldIndex, newIndex),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      exitEditing();
                      saveChanges();
                      print("Save and Next");
                      // Perform any additional actions here
                    },
                    child: const Text(
                      "Save and Next",
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 163, 72, 155),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
