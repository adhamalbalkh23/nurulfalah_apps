import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/database/prefernce.dart';
import 'package:nurulfalah_apps/database/sqflite.dart';
import 'package:nurulfalah_apps/pages_laporan%20CRUD/editlaporan.dart';
import 'package:nurulfalah_apps/pages_laporan%20CRUD/tambahlaporan.dart';
import 'package:lottie/lottie.dart';

class Laporanadmin extends StatefulWidget {
  const Laporanadmin({super.key});

  @override
  State<Laporanadmin> createState() => _LaporankegiatanPageState();
}

class _LaporankegiatanPageState extends State<Laporanadmin> {
  String? role = "user"; // nanti diambil dari login
  @override
  void initState() {
    super.initState();
    getRole();
  }

  void getRole() async {
    var roleuser = await PreferenceHandler.getRole();
    role = roleuser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laporan Kegiatan"),
        backgroundColor: Color(0xfff90C67C),
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      backgroundColor: Colors.white,

      floatingActionButton: role == "admin"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TambahLaporanPage()),
                ).then((_) => setState(() {}));
              },
              backgroundColor: Colors.green,
              child: Icon(Icons.add, color: Colors.white),
            )
          : null,

      body: FutureBuilder(
        future: DbHelper.getLaporan(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data as List;

          /// JIKA BELUM ADA LAPORAN
          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/animations/empty.json", height: 200),

                  SizedBox(height: 20),

                  Text(
                    "Belum ada laporan kegiatan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
                  ),

                  SizedBox(height: 6),

                  Text(
                    "Laporan kegiatan masjid akan muncul di sini",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            );
          }

          /// JIKA ADA DATA
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];

              return Container(
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Color(0xff90C67C),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 16,
                      spreadRadius: 1,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// GAMBAR
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                      child: Image.file(
                        File(item["gambar"]),
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
                            item["tanggal"],
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),

                          SizedBox(height: 6),

                          Text(
                            item["judul"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            item["deskripsi"],
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),

                          SizedBox(height: 10),

                          if (role == "admin")
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditLaporanPage(data: item),
                                      ),
                                    ).then((_) => setState(() {}));
                                  },
                                ),

                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    await DbHelper.deleteLaporan(item["id"]);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
