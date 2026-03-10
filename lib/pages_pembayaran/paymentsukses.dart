import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/database/prefernce.dart';
import 'package:nurulfalah_apps/database/sqflite.dart';
import 'package:nurulfalah_apps/extension/navigator.dart';
import 'package:nurulfalah_apps/bottomnavbar_global.dart';
import 'package:nurulfalah_apps/pages/home_page.dart';
import 'package:nurulfalah_apps/pages/riwayatdonasi_page.dart';
import 'package:nurulfalah_apps/pages_pembayaran/riwayatcrud.dart';
import 'package:lottie/lottie.dart';

class Paymentsukses extends StatelessWidget {
  final String jenis;
  final int nominal;
  final String metode;

  const Paymentsukses({
    super.key,
    required this.jenis,
    required this.nominal,
    required this.metode,
  });

  String formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}.")}";
  }

  @override
  Widget build(BuildContext context) {
    String idTransaksi = "ZKT-${DateTime.now().millisecondsSinceEpoch}";
    String waktu =
        "${DateTime.now().day} Okt, ${DateTime.now().hour}:${DateTime.now().minute} WIB";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () =>
                      context.pushAndRemoveAll(Bottomnavbar(role: "user")),
                ),
              ),

              SizedBox(height: 8),

              /// ANIMASI SUCCESS
              Lottie.asset(
                "assets/animations/gopay_succesfull_payment.json",
                width: 185,
                repeat: true,
              ),

              Text(
                "Alhamdulillah, Donasi Berhasil!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 8),

              Text(
                "Terima kasih telah menunaikan kewajiban $jenis Anda.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),

              SizedBox(height: 18),

              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  boxShadow: [BoxShadow(color: Colors.black12)],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text("TOTAL DONASI", style: TextStyle(color: Colors.grey)),

                    SizedBox(height: 8),

                    Text(
                      formatRupiah(nominal),
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Berhasil",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("ID Transaksi"), Text(idTransaksi)],
                    ),

                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Waktu"), Text(waktu)],
                    ),

                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Metode"), Text(metode)],
                    ),

                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Program"), Text(jenis)],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    context.pushAndRemoveAll(Bottomnavbar(role: "user"));
                  },
                  child: Text(
                    "Kembali ke Beranda",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  onPressed: () {
                    context.push(Riwayatcrud());
                  },
                  child: Text("Lihat Riwayat"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
