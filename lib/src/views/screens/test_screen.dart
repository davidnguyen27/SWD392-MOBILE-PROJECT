import 'package:flutter/material.dart';

class CryptoScreen extends StatelessWidget {
  const CryptoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crypto',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Crypto Prices',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildCryptoTile(
              context,
              icon: Icons.currency_bitcoin,
              cryptoName: 'Bitcoin',
              price: '\$50,000',
              change: '+5.2%',
            ),
            _buildCryptoTile(
              context,
              icon: Icons.attach_money,
              cryptoName: 'Ethereum',
              price: '\$4,000',
              change: '+3.8%',
            ),
            _buildCryptoTile(
              context,
              icon: Icons.money,
              cryptoName: 'Ripple',
              price: '\$1.25',
              change: '-2.5%',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Xử lý khi mua crypto
              },
              child: const Text('Buy Crypto'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCryptoTile(BuildContext context,
      {required IconData icon,
      required String cryptoName,
      required String price,
      required String change}) {
    return ListTile(
      leading: Icon(icon, size: 40, color: Colors.orange),
      title: Text(cryptoName, style: const TextStyle(fontSize: 18)),
      subtitle: Text('Price: $price'),
      trailing: Text(
        change,
        style: TextStyle(
          color: change.contains('-') ? Colors.red : Colors.green,
          fontSize: 16,
        ),
      ),
      onTap: () {
        // Xử lý khi bấm vào từng loại crypto
      },
    );
  }
}
