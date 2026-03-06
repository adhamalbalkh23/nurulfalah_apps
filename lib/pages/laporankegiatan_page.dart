import 'package:flutter/material.dart';

class LaporankegiatanPage extends StatelessWidget {
  LaporankegiatanPage({super.key});
  final List laporan = [
    {
      "image": "assets/images/sembako 1.jpg",
      "date": "15 Feb 2026",
      "title": "Penyaluran 20 Paket Sembako untuk Dhuafa",
      "desc":
          "Alhamdulillah, amanah Anda telah kami sampaikan kepada 20 keluarga prasejahtera di warga sekitar.",
    },
    {
      "image": "assets/images/Santunan anak yatim.jpg",
      "date": "01 Nov 2025",
      "title": "Santunan Anak - Anak Yatim",
      "desc":
          "Penyaluran santunan anak yatim dari sekitar warga masjid dan panti asuhan terdekat dari lokasi.",
    },
    {
      "image": "assets/images/renovasi 2.jpg",
      "date": "28 Jan 2026",
      "title": "Renovasi Masjid",
      "desc": "Progres renovasi Masjid Nuruul Falaah.",
    },
    {
      "image": "assets/images/pembagian 3.jpg",
      "date": "12 Feb 2025",
      "title": "Pembagian Jum'at Berkah",
      "desc":
          "Penyaluran nasi berkah untuk jamaah sholat Jum'at dan warga sekitar",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporan Kegiatan"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      backgroundColor: Colors.white,

      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: laporan.length,
        itemBuilder: (context, index) {
          final item = laporan[index];

          return Container(
            margin: EdgeInsets.only(bottom: 20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                  child: Image.asset(
                    item["image"],
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["date"],
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),

                      SizedBox(height: 6),

                      Text(
                        item["title"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        item["desc"],
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),

                      SizedBox(height: 10),

                      Text(
                        "Lihat Detail →",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
