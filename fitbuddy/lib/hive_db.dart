import 'package:fitbuddy/date_time.dart';
import 'package:fitbuddy/exercise.dart';
import 'package:fitbuddy/workout.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  final _mybox = Hive.box("workoutBox1");
  bool previousDataExists() {
    if (_mybox.isEmpty) {
      print("no data");
      _mybox.put("START_DATE", todaysDateYYYYMMDD());
      return false;
    } else {
      print("data exists");
      return true;
    }
  }

  String getStartDate() {
    return _mybox.get("START_DATE");
  }

  void saveToDatabase(List<Workout> workouts) {
    final workoutList = convertObjectToWorkout(workouts);
    final exerciseList = convertObjectToExercise(workouts);

    if (exerciseCompleted(workouts)) {
      _mybox.put("COMPLETED_DATE" + todaysDateYYYYMMDD(), 1);
    } else {
      _mybox.put("COMPLETED_DATE" + todaysDateYYYYMMDD(), 0);
    }

    _mybox.put("WORKOUT_LIST", workoutList);
    _mybox.put("EXERCISE_LIST", exerciseList);
  }

  List<Workout> readFromDatabase() {
    List<Workout> workouts = [];
    List<String> workoutList = _mybox.get("WORKOUT_LIST");
    final exercisesList = _mybox.get("EXERCISE_LIST");

    for (int i = 0; i < workoutList.length; i++) {
      List<Exercise> exercises = [];
      for (int j = 0; j < exercisesList[i].length; j++) {
        exercises.add(Exercise(
          name: exercisesList[i][j][0],
          weight: exercisesList[i][j][1],
          reps: exercisesList[i][j][2],
          sets: exercisesList[i][j][3],
          isCompleted: exercisesList[i][j][4] == "true" ? true : false,
        ));
      }
      Workout workout = Workout(name: workoutList[i], exercises: exercises);

      workouts.add(workout);
    }
    return workouts;
  }

  bool exerciseCompleted(List<Workout> workouts) {
    for (var workout in workouts) {
      for (var exercise in workout.exercises) {
        if (exercise.isCompleted) {
          return true;
        }
      }
    }
    return false;
  }

  int getCompletionStatus(String yyyymmdd) {
    int completionStatus = _mybox.get("COMPLETED_DATE$yyyymmdd") ?? 0;
    return completionStatus;
  }
}

List<String> convertObjectToWorkout(List<Workout> workouts) {
  List<String> workoutList = [];

  for (int i = 0; i < workouts.length; i++) {
    workoutList.add(workouts[i].name);
  }
  return workoutList;
}

List<List<List<String>>> convertObjectToExercise(List<Workout> workouts) {
  List<List<List<String>>> exerciseList = [];

  for (int i = 0; i < workouts.length; i++) {
    List<Exercise> exercises = workouts[i].exercises;
    List<List<String>> exerciseListPerWorkout = [];
    for (int j = 0; j < exercises.length; j++) {
      List<String> exercise = [];
      exercise.addAll([
        exercises[j].name,
        exercises[j].weight,
        exercises[j].reps,
        exercises[j].sets,
        exercises[j].isCompleted.toString(),
      ]);
      exerciseListPerWorkout.add(exercise);
    }
    exerciseList.add(exerciseListPerWorkout);
  }
  return exerciseList;
}
