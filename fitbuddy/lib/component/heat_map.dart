import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
//import 'date_time.dart';

class heatmap extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  const heatmap({super.key, required this.datasets});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(25),
      child: HeatMapCalendar(
        datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200]!,
        textColor: Colors.black,
        weekTextColor: Colors.red,
        weekFontSize: 20,
        showColorTip: false,
        monthFontSize: 25,
        size: 42,
        colorsets: const {1: Colors.green},
      ),
    );
  }
}
