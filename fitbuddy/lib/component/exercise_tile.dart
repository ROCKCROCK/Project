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
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isCompleted ? Colors.green : Colors.green[100],
      ),
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
