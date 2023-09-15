import 'package:fitbuddy/workout_page.dart';
import 'package:flutter/material.dart';

class fit extends StatefulWidget {
  const fit({super.key});

  @override
  State<fit> createState() => _fitState();
}

class _fitState extends State<fit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 196, 67, 110),
                  Color.fromARGB(255, 255, 123, 67)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                bottom: 300,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 400,
                      scale: 0.1,
                    ),
                    const Text(
                      'FIT BUDDY',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                  bottom: 200,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const workoutPage()));
                      },
                      child: Container(
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(239, 221, 91, 35),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: const Center(
                          child: Text(
                            'Let\'s Workout',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
