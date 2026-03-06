import 'package:flutter/material.dart';

class RiwayatdonasiPage extends StatelessWidget {
  const RiwayatdonasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      appBar: AppBar(
        title: const Text("Riwayat Donasi"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Bulan Ini",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 12),

          donasiCard(
            icon: Icons.account_balance,
            color: Colors.pinkAccent,
            title: "Zakat Mal",
            date: "12 Okt • 10:30",
            amount: "Rp 2.500.000",
          ),

          donasiCard(
            icon: Icons.favorite,
            color: Colors.redAccent,
            title: "Infaq Masjid",
            date: "10 Okt • 14:15",
            amount: "Rp 150.000",
          ),

          donasiCard(
            icon: Icons.mosque,
            color: Colors.green,
            title: "Infaq Jum’at",
            date: "05 Okt • 09:45",
            amount: "Rp 500.000",
          ),

          const SizedBox(height: 20),

          const Text(
            "September 2023",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),

          const SizedBox(height: 12),

          donasiCard(
            icon: Icons.wb_sunny,
            color: Colors.deepOrangeAccent,
            title: "Sedekah Subuh",
            date: "28 Sep • 11:20",
            amount: "Rp 1.000.000",
          ),

          donasiCard(
            icon: Icons.work,
            color: Colors.deepPurpleAccent,
            title: "Zakat Penghasilan",
            date: "25 Sep • 16:00",
            amount: "Rp 750.000",
          ),
        ],
      ),
    );
  }

  Widget donasiCard({
    required IconData icon,
    required Color color,
    required String title,
    required String date,
    required String amount,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),

            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                Text(
                  date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
