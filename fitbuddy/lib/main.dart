import 'package:fitbuddy/firebase_options.dart';
import 'package:fitbuddy/page/home.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:fitbuddy/db/workout_data.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('workoutBox1');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const fit_buddy());
}

class fit_buddy extends StatelessWidget {
  const fit_buddy({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutData(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: fit(),
      ),
    );
  }
}
