import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/services/size_service.dart';
import 'package:t_shirt_football_project/src/models/size.dart';
import 'package:t_shirt_football_project/src/ui/size.manage/size_card.dart';

class SizeManageScreen extends StatefulWidget {
  const SizeManageScreen({super.key});

  @override
  _SizeManageScreenState createState() => _SizeManageScreenState();
}

class _SizeManageScreenState extends State<SizeManageScreen> {
  late Future<List<Size>> _sizes;

  @override
  void initState() {
    super.initState();
    _loadSizes();
  }

  Future<void> _loadSizes() async {
    setState(() {
      _sizes = SizeService.getAllSizes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Size Management'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Size>>(
        future: _sizes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final sizes = snapshot.data!;
            return ListView.builder(
              itemCount: sizes.length,
              itemBuilder: (context, index) {
                final size = sizes[index];
                return SizeCardItem(
                  name: size.name,
                  description: size.description,
                  status: size.status,
                  size: size,
                );
              },
            );
          } else {
            return const Center(child: Text('No sizes available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(context, '/size-add');
          if (result == true) {
            _loadSizes();
          }
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
