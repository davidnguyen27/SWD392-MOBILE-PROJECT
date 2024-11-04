import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:t_shirt_football_project/src/models/dashboard.dart';

class InvoiceHistoryChart extends StatelessWidget {
  final DashboardData data;

  const InvoiceHistoryChart({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> sections = [];

    if (data.shirtCount > 0) {
      sections.add(
        PieChartSectionData(
          value: data.shirtCount.toDouble(),
          color: Colors.blue,
          title: 'Shirts: ${data.shirtCount}',
          radius: 50,
        ),
      );
    }

    if (data.typeShirtCount > 0) {
      sections.add(
        PieChartSectionData(
          value: data.typeShirtCount.toDouble(),
          color: Colors.green,
          title: 'Types: ${data.typeShirtCount}',
          radius: 50,
        ),
      );
    }

    // Kiểm tra nếu sections không rỗng, hiển thị PieChart, ngược lại hiển thị thông báo "No data available"
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Product", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            SizedBox(
              height: 150,
              child: sections.isNotEmpty
                  ? PieChart(
                      PieChartData(
                        sections: sections,
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                      ),
                    )
                  : const Center(child: Text("No data available for chart")),
            ),
          ],
        ),
      ),
    );
  }
}
