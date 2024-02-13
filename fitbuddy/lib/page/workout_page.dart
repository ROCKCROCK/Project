import 'package:fitbuddy/page/side_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fitbuddy/db/workout_data.dart';
import 'package:fitbuddy/page/exercise_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../component/heat_map.dart';

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
        title: const Text("Edit Workout Name"),
        content: TextField(
          controller: newWorkoutNameController,
          decoration: const InputDecoration(
            labelText: "Workout Name",
            hintText: "Enter Workout Name",
          ),
        ),
        actions: [
          MaterialButton(
              onPressed: () => save1(workoutName), child: const Text("Save")),
          MaterialButton(onPressed: cancel, child: const Text("Cancel")),
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
        drawer: sidedrawer(),
        appBar: AppBar(
          title: const Text('Workout'),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewWorkout,
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            heatmap(
              datasets: value.heatMapDataSet,
            ),
            Expanded(
              child: ListView.builder(
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
                        autoClose: true,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                      SlidableAction(
                        onPressed: (context) =>
                            editWorkoutName(value.getWorkoutList()[index].name),
                        autoClose: true,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                    ],
                  ),
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFd90429),
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () =>
                          gotoExercise(value.getWorkoutList()[index].name),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          value.getWorkoutList()[index].name,
                          style: TextStyle(fontSize: 40),
                        ),
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
