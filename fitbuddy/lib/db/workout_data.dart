import 'package:fitbuddy/db/date_time.dart';
import 'package:fitbuddy/db/exercise.dart';
import 'package:fitbuddy/db/workout.dart';
import 'package:fitbuddy/db/hive_db.dart';
import 'package:flutter/material.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();
  List<Workout> workoutList = [
    Workout(
      name: "Chest",
      exercises: [
        Exercise(
            name: "flat dumbble press", weight: "40", reps: "10", sets: "8"),
      ],
    ),
  ];
  void initializeWorkoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDatabase();
    } else {
      db.saveToDatabase(workoutList);
    }
    loadHeatMap();
  }

  List<Workout> getWorkoutList() {
    return workoutList;
  }

  int numberOfWorkout(String workoutName) {
    Workout relevantWorkout = getWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout = getWorkout(workoutName);
    relevantWorkout.exercises.add(
      Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets),
    );
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  void checkoffExercise(String workoutName, String exerciseName) {
    Exercise relevantExercise = getExercise(workoutName, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
    db.saveToDatabase(workoutList);
    loadHeatMap();
  }

// edit workout name
  void editWorkoutName(String workoutName, String newWorkoutName) {
    Workout relevantWorkout = getWorkout(workoutName);
    relevantWorkout.name = newWorkoutName;
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  Workout getWorkout(String workoutName) {
    return workoutList.firstWhere((workout) => workout.name == workoutName);
  }

  Exercise getExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getWorkout(workoutName);
    return relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
  }

  String getStartDate() {
    return db.getStartDate();
  }

  Map<DateTime, int> heatMapDataSet = {};
  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(getStartDate());
    int daysBtwn = DateTime.now().difference(startDate).inDays;
    for (int i = 0; i < daysBtwn + 1; i++) {
      String yyyymmdd =
          convertDateTimetoYYYYMMDD(startDate.add(Duration(days: i)));

      int completionStatus = db.getCompletionStatus(yyyymmdd);

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;
      final eachDay = <DateTime, int>{
        DateTime(year, month, day): completionStatus,
      };

      heatMapDataSet.addEntries(eachDay.entries);
    }
  }

  void deleteWorkout(int index) {
    workoutList.removeAt(index);
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  void deleteWorkout1(String workoutName, int index) {
    Workout relevantWorkout = getWorkout(workoutName);
    relevantWorkout.exercises.removeAt(index);
    notifyListeners();
    db.saveToDatabase(workoutList);
  }
}
