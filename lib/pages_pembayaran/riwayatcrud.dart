import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nurulfalah_apps/database/prefernce.dart';
import 'package:nurulfalah_apps/database/sqflite.dart';

class Riwayatcrud extends StatefulWidget {
  const Riwayatcrud({super.key});

  @override
  State<Riwayatcrud> createState() => _RiwayatdonasiPageState();
}

class _RiwayatdonasiPageState extends State<Riwayatcrud> {
  List dataDonasi = [];

  void loadDonasi() async {
    int? userId = await PreferenceHandler.getUserId();
    print("UserID: $userId"); // DEBUG

    if (userId != null) {
      final data = await DbHelper.getDonasiUser(userId);
      print("Data Donasi: $data"); // DEBUG
      setState(() {
        dataDonasi = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadDonasi();
  }

  final formatRupiah = NumberFormat("#,###", "id_ID");
  IconData getIcon(String jenis) {
    if (jenis.contains("Zakat")) {
      return Icons.account_balance;
    }
    if (jenis.contains("Infaq")) {
      return Icons.favorite;
    }
    if (jenis.contains("Sedekah")) {
      return Icons.wb_sunny;
    }
    return Icons.volunteer_activism;
  }

  Color getColor(String jenis) {
    if (jenis.contains("Zakat")) {
      return Colors.pink;
    }
    if (jenis.contains("Infaq")) {
      return Colors.red;
    }
    if (jenis.contains("Sedekah")) {
      return Colors.orange;
    }
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riwayat Donasi"),
        backgroundColor: Color(0xfff90C67C),
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      backgroundColor: Colors.grey.shade100,

      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: dataDonasi.length,
        itemBuilder: (context, index) {
          final item = dataDonasi[index];

          return Container(
            margin: EdgeInsets.only(bottom: 16),

            padding: EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),

            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: getColor(item["jenis"]).withOpacity(0.1),
                  child: Icon(
                    getIcon(item["jenis"]),
                    color: getColor(item["jenis"]),
                  ),
                ),

                SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["jenis"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        item["tanggal"],
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),

                Text(
                  "Rp ${formatRupiah.format(item["nominal"])}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
