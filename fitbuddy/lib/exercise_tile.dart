import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String exerciseName;
  final String weight;
  final String reps;
  final String sets;
  final bool isCompleted;
  final void Function(bool?)? onBoxChanged;
  const ExerciseTile(
      {super.key,
      required this.exerciseName,
      required this.weight,
      required this.reps,
      required this.sets,
      required this.isCompleted,
      required this.onBoxChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: ListTile(
          title: Text(exerciseName),
          subtitle: Row(
            children: [
              Chip(label: Text("${weight}kg")),
              Chip(label: Text("$reps reps")),
              Chip(label: Text("$sets sets")),
            ],
          ),
          trailing: Checkbox(
            value: isCompleted,
            onChanged: (value) => onBoxChanged!(value),
          )),
    );
  }
}
