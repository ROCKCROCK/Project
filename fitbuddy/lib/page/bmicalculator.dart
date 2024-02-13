import 'package:fitbuddy/component/calculate_bmi.dart';
import 'package:fitbuddy/page/result_bmi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class BMI_page extends StatefulWidget {
  const BMI_page({super.key});

  @override
  State<BMI_page> createState() => _BMI_pageState();
}

class _BMI_pageState extends State<BMI_page> {
  int val = 45;
  int hval = 150;
  void increase_weight() {
    setState(() {
      val++;
    });
  }

  void decrease_weight() {
    setState(() {
      val--;
    });
  }

  void calculateBMI() {
    double bmi = CalculateBMI.calculateBMI(val, hval);
    String bmiCategory = CalculateBMI.determineBMICategory(bmi);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return bmi_result(
          bmi: bmi,
          bmiCategory: bmiCategory,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[400],
      body: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            const Text(
              'Height(in cm)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ).animate(),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Image.asset('assets/heightimg.png'),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 350,
                  width: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SfSlider.vertical(
                    min: 100.0,
                    max: 300.0,
                    value: hval.toDouble(),
                    interval: 50,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    minorTicksPerInterval: 3,
                    onChanged: (dynamic value) {
                      setState(() {
                        hval = value.toInt();
                      });
                    },
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Weight(in kg)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ).animate(),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Image.asset('assets/weightimg.png', height: 200, width: 200),
                Container(
                    height: 180,
                    width: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          '$val',
                          style: const TextStyle(
                            fontSize: 70,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: increase_weight,
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: Colors.red[400]),
                                child: const Icon(
                                  Icons.add,
                                  size: 30,
                                  color: Colors.white,
                                )),
                            ElevatedButton(
                                onPressed: decrease_weight,
                                style: ElevatedButton.styleFrom(
                                    elevation: 10,
                                    backgroundColor: Colors.red[400]),
                                child: const Icon(
                                  Icons.remove,
                                  size: 30,
                                  color: Colors.white,
                                )),
                          ],
                        )
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                ),
                child: const Text('Calculate BMI',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ))),
          ],
        ),
      ),
    );
  }
}
