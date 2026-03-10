import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/database/prefernce.dart';
import 'package:nurulfalah_apps/database/sqflite.dart';
import 'package:nurulfalah_apps/pages_pembayaran/paymentsukses.dart';

class QrisPage extends StatelessWidget {
  final String jenis;
  final int nominal;

  const QrisPage({super.key, required this.jenis, required this.nominal});
  String formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pembayaran"), centerTitle: true),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 10),

            Text(
              "TOTAL PEMBAYARAN",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),

            SizedBox(height: 6),

            Text(
              formatRupiah(nominal),
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.timer, size: 16, color: Colors.orange),
                SizedBox(width: 4),
                Text(
                  "Selesaikan dalam 23:59:59",
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
              ],
            ),

            SizedBox(height: 30),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "https://www.pngall.com/wp-content/uploads/2/QR-Code.png",
                  height: 420,
                  width: 420,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  int? userId = await PreferenceHandler.getUserId();

                  if (userId != null) {
                    await DbHelper.insertDonasi(userId, jenis, nominal);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Paymentsukses(
                        jenis: jenis,
                        nominal: nominal,
                        metode: "Qris",
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Selesai ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
