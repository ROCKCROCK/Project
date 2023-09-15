import 'package:fitbuddy/exercise_tile.dart';
import 'package:fitbuddy/workout_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class exercisePage extends StatefulWidget {
  final String workoutName;
  const exercisePage({super.key, required this.workoutName});

  @override
  State<exercisePage> createState() => _exercisePageState();
}

class _exercisePageState extends State<exercisePage> {
  void onBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkoffExercise(workoutName, exerciseName);
  }

  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  void createExercise() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Create Exercise"),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(
                  controller: exerciseNameController,
                  decoration: InputDecoration(
                    labelText: "Exercise Name",
                    hintText: "Enter Exercise Name",
                  ),
                ),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                    labelText: "Weight",
                    hintText: "Enter Weight",
                  ),
                ),
                TextField(
                  controller: repsController,
                  decoration: InputDecoration(
                    labelText: "Reps",
                    hintText: "Enter Reps",
                  ),
                ),
                TextField(
                  controller: setsController,
                  decoration: InputDecoration(
                    labelText: "Sets",
                    hintText: "Enter Sets",
                  ),
                ),
              ]),
              actions: [
                MaterialButton(onPressed: save, child: Text("Save")),
                MaterialButton(onPressed: cancel, child: Text("Cancel")),
              ],
            ));
  }

  void save() {
    String exerciseName = exerciseNameController.text;
    String weight = weightController.text;
    String reps = repsController.text;
    String sets = setsController.text;
    Provider.of<WorkoutData>(context, listen: false)
        .addExercise(widget.workoutName, exerciseName, weight, reps, sets);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: createExercise,
            child: const Icon(Icons.add),
          ),
          body: Container(
            margin: const EdgeInsets.all(25),
            child: ListView.builder(
                itemCount: value.numberOfWorkout(widget.workoutName),
                itemBuilder: (context, index) => ExerciseTile(
                      exerciseName: value
                          .getWorkout(widget.workoutName)
                          .exercises[index]
                          .name,
                      weight: value
                          .getWorkout(widget.workoutName)
                          .exercises[index]
                          .weight,
                      reps: value
                          .getWorkout(widget.workoutName)
                          .exercises[index]
                          .reps,
                      sets: value
                          .getWorkout(widget.workoutName)
                          .exercises[index]
                          .sets,
                      isCompleted: value
                          .getWorkout(widget.workoutName)
                          .exercises[index]
                          .isCompleted,
                      onBoxChanged: (val) => onBoxChanged(
                          widget.workoutName,
                          value
                              .getWorkout(widget.workoutName)
                              .exercises[index]
                              .name),
                    )),
          )),
    );
  }
}
