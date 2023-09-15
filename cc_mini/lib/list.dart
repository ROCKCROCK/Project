import 'package:flutter/material.dart';
import 'sections.dart';

class ListViewWidget extends StatefulWidget {
  final Sections section;

  const ListViewWidget({Key? key, required this.section}) : super(key: key);

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  bool isSwitched = false;
  TextEditingController textFieldController = TextEditingController();
  final MaterialStateProperty<Icon?> iconChange =
      MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return const Icon(Icons.check, color: Colors.white);
    }
    return Icon(Icons.close);
  });
  void savetext(String newText) {
    setState(() {
      widget.section.name = newText;
    });
  }

  void toggleEditing() {
    setState(() {
      widget.section.isEditing = !(widget.section.isEditing ?? false);
      if (!(widget.section.isEditing ?? false)) {
        // Save the changes or perform any necessary action
        String newText = textFieldController.text;
        savetext(newText);
      }
    });
  }

  void showDescription() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Description'),
          content: Text(widget.section.description ?? ''),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    textFieldController.text = widget.section.name ?? '';
  }

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.section.isEditing ?? false;

    return Container(
      key: widget.key,
      padding: const EdgeInsets.all(4),
      child: ListTile(
        tileColor: isEditing ? Colors.grey : null,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(Icons.menu),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: showDescription,
              child: Icon(Icons.info_outline),
            )
          ],
        ),
        title: (isEditing)
            ? TextFormField(
                controller: textFieldController,
                decoration: InputDecoration(
                  hintText: widget.section.name!,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(0),
                      right: Radius.circular(0),
                    ),
                    borderSide: BorderSide(width: 0),
                  ),
                  alignLabelWithHint: true,
                ),
              )
            : Text(widget.section.name!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: toggleEditing,
              child: Icon(Icons.edit),
            ),
            SizedBox(width: 10),
            Switch(
              thumbIcon: iconChange,
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
              activeTrackColor: Colors.purple[200],
              activeColor: Colors.purple[900],
            ),
          ],
        ),
      ),
    );
  }
}
