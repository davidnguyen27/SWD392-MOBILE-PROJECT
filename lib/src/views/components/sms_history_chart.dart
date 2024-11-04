import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:t_shirt_football_project/src/models/dashboard.dart';

class SmsHistoryChart extends StatelessWidget {
  final DashboardData data;

  const SmsHistoryChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("General", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, data.sessionCount.toDouble()),
                        FlSpot(1, data.orderCount.toDouble()),
                        FlSpot(2, data.userCount.toDouble()),
                        FlSpot(3, data.clubCount.toDouble()),
                      ],
                      isCurved: true,
                      colors: [Colors.blue],
                      barWidth: 3,
                      isStrokeCapRound: true,
                      belowBarData: BarAreaData(
                        show: true,
                        colors: [Colors.blue.withOpacity(0.3)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
