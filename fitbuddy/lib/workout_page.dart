import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitbuddy/workout_data.dart';
import 'package:fitbuddy/exercise_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'heat_map.dart';

class workoutPage extends StatefulWidget {
  const workoutPage({super.key});
  @override
  State<workoutPage> createState() => _workoutPageState();
}

class _workoutPageState extends State<workoutPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
}

  final newWorkoutNameController = TextEditingController();
  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Create Workout"),
        content: TextField(
          controller: newWorkoutNameController,
          decoration: InputDecoration(
            labelText: "Workout Name",
            hintText: "Enter Workout Name",
          ),
        ),
        actions: [
          MaterialButton(onPressed: save, child: Text("Save")),
          MaterialButton(onPressed: cancel, child: Text("Cancel")),
        ],
      ),
    );
  }

// edit workout name
  void editWorkoutName(String workoutName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Workout Name"),
        content: TextField(
          controller: newWorkoutNameController,
          decoration: InputDecoration(
            labelText: "Workout Name",
            hintText: "Enter Workout Name",
          ),
        ),
        actions: [
          MaterialButton(
              onPressed: () => save1(workoutName), child: Text("Save")),
          MaterialButton(onPressed: cancel, child: Text("Cancel")),
        ],
      ),
    );
  }

  void gotoExercise(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => exercisePage(
                  workoutName: workoutName,
                )));
  }

//delete workout
  void deleteWorkout(int index) {
    Provider.of<WorkoutData>(context, listen: false).deleteWorkout(index);
  }

  void save() {
    String name = newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(name);
    Navigator.pop(context);
    clear();
  }

  void save1(String workoutName) {
    String name = newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false)
        .editWorkoutName(workoutName, name);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.red,
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [
            heatmap(
              datasets: value.heatMapDataSet,
              startDateYYYYMMDD: value.getStartDate(),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getWorkoutList().length,
              itemBuilder: (context, index) => Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  extentRatio: 0.7,
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => deleteWorkout(index),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      backgroundColor: Color.fromARGB(229, 192, 117, 3),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (context) =>
                          editWorkoutName(value.getWorkoutList()[index].name),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      backgroundColor: Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  margin: const EdgeInsets.all(25),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ).merge(
                      ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(
                            0), // Remove button elevation
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () =>
                        gotoExercise(value.getWorkoutList()[index].name),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        value.getWorkoutList()[index].name,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
