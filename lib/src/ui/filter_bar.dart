import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            // Action khi bấm Filter List
          },
          icon: const Icon(Icons.add),
          label: const Text("Filter List"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {
            // Action khi bấm Open Filter
          },
          icon: const Icon(Icons.filter_alt),
          label: const Text("Open Filter"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
          ),
        ),
      ],
    );
  }
}
