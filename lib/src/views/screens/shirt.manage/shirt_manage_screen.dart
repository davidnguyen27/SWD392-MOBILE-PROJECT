import 'package:flutter/material.dart';
import 'package:t_shirt_football_project/src/services/shirt_service.dart';
import 'package:t_shirt_football_project/src/ui/shirt_item_card.dart';
import 'package:t_shirt_football_project/src/models/shirt.dart';

class ShirtManageScreen extends StatefulWidget {
  const ShirtManageScreen({super.key});

  @override
  _ShirtManageScreenState createState() => _ShirtManageScreenState();
}

class _ShirtManageScreenState extends State<ShirtManageScreen> {
  late Future<List<Shirt>> _futureShirts;

  @override
  void initState() {
    super.initState();
    _futureShirts = ShirtService.getShirts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shirt Management'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Shirt>>(
                future: _futureShirts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    final shirts = snapshot.data!;
                    if (shirts.isEmpty) {
                      return const Center(child: Text('No shirts available'));
                    }
                    return ListView.builder(
                      itemCount: shirts.length,
                      itemBuilder: (context, index) {
                        final shirt = shirts[index];
                        return ShirtItemCard(
                          name: shirt.name,
                          id: shirt.id.toString(),
                          date: shirt.date.toString().substring(0, 10),
                          imageUrl: shirt.urlImg,
                          price: shirt.price.toString(),
                          playerName: shirt.playerName,
                        );
                      },
                    );
                  }
                  return const Center(child: Text('No data available'));
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/shirt-add');
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add), // Biểu tượng dấu cộng
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat, // Vị trí góc dưới bên phải
    );
  }
}
