import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class InvoiceHistoryChart extends StatelessWidget {
  const InvoiceHistoryChart({super.key});

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
            const Text("Invoice History", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 37,
                      color: Colors.green,
                      title: 'React 37%',
                      radius: 50,
                      titleStyle:
                          const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    PieChartSectionData(
                      value: 63,
                      color: Colors.red,
                      title: 'Flutter 63%',
                      radius: 50,
                      titleStyle:
                          const TextStyle(fontSize: 14, color: Colors.white),
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
