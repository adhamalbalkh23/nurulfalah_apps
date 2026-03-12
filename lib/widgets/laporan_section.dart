import 'package:flutter/material.dart';

class LaporanSection extends StatelessWidget {
  const LaporanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Laporan Terkini",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(height: 12),

        SizedBox(
          height: 230,
          child: ListView(
            scrollDirection: Axis.horizontal, // Biar bisa di scroll ke samping
            padding: EdgeInsets.only(left: 16),
            children: [
              // Laporan 1
              Container(
                width: 260,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Color(0xfff90C67C),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      child: Image.asset(
                        "assets/images/pembagian 1.jpg",
                        height: 130,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Paket Sembako Untuk Warga Sekitar",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Penyaluran 50 Paket Sembako.",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Laporan 2
              Container(
                width: 260,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Color(0xfff90C67C),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      child: Image.asset(
                        "assets/images/pembagian 2.jpg",
                        height: 130,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Paket Sembako Ramadhan",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Bantuan sembako untuk warga sekitar.",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Laporan 3
              Container(
                width: 260,
                decoration: BoxDecoration(
                  color: Color(0xfff90C67C),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      child: Image.asset(
                        "assets/images/pembagian 3.jpg",
                        height: 130,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Paket Nasi Jum'at Berkah",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 6),
                          Text(
                            "Penyaluran nasi untuk jamaah sholat Jum'at .",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
