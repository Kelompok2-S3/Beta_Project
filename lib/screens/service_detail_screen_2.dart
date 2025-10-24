import 'package:flutter/material.dart';

class ServiceDetailScreen2 extends StatelessWidget {
  final String serviceTitle;
  final String serviceDescription;

  const ServiceDetailScreen2({
    super.key,
    required this.serviceTitle,
    required this.serviceDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serviceTitle,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              serviceDescription,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            // You can add more widgets here for additional details
            _buildInfoCard(
              icon: Icons.access_time,
              title: 'Estimasi Waktu',
              subtitle: '30 - 60 menit',
            ),
            _buildInfoCard(
              icon: Icons.price_change,
              title: 'Harga Mulai Dari',
              subtitle: 'Rp 50.000',
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Aksi ketika tombol ditekan
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pesan Layanan Ditekan!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Pesan Layanan Ini',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String subtitle}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueAccent, size: 30),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
