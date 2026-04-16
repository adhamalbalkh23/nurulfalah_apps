import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/database/prefernce.dart';
import 'package:nurulfalah_apps/service/laporan_service.dart';
import 'package:nurulfalah_apps/models/laporan_model.dart';
import 'package:nurulfalah_apps/pages_laporan%20dkm/editlaporan.dart';
import 'package:nurulfalah_apps/pages_laporan%20dkm/tambahlaporan.dart';
import 'package:lottie/lottie.dart';

class Laporanadmin extends StatefulWidget {
  const Laporanadmin({super.key});

  @override
  State<Laporanadmin> createState() => _LaporankegiatanPageState();
}

class _LaporankegiatanPageState extends State<Laporanadmin> {
  String? role = "user"; // nanti diambil dari login
  final LaporanService _laporanService = LaporanService();
  late Future<List<LaporanModel>> _laporanFuture;

  @override
  void initState() {
    super.initState();
    _laporanFuture = _laporanService.getLaporan();
    getRole();
  }

  void getRole() async {
    var roleuser = await PreferenceHandler.getRole();
    role = roleuser;
    setState(() {});
  }

  void _refreshLaporan() {
    setState(() {
      _laporanFuture = _laporanService.getLaporan();
    });
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
                ).then((_) => _refreshLaporan());
              },
              backgroundColor: Colors.green,
              child: Icon(Icons.add, color: Colors.white),
            )
          : null,

      body: FutureBuilder<List<LaporanModel>>(
        future: _laporanFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data as List<LaporanModel>;

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
                      child: _buildLaporanImage(item),
                    ),
                    if (item.isLocal)
                      Padding(
                        padding: EdgeInsets.fromLTRB(14, 10, 14, 0),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.tanggal
                                .toString()
                                .split('.')
                                .first, // Format tanggal
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          SizedBox(height: 6),
                          Text(
                            item.judul,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            item.deskripsi,
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
                                    ).then((_) => _refreshLaporan());
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Hapus Laporan"),
                                          content: Text(
                                            "Apakah Anda yakin ingin menghapus laporan ini?",
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text("Batal"),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                await _laporanService
                                                    .deleteLaporan(
                                                      laporanId: item.id,
                                                      imageUrl: item.gambar,
                                                      isLocal: item.isLocal,
                                                    );
                                                _refreshLaporan();
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "Laporan berhasil dihapus",
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                "Hapus",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
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

  Widget _buildLaporanImage(LaporanModel item) {
    final imageWidget = item.isLocal || !item.gambar.startsWith('http')
        ? Image.file(
            File(item.gambar),
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildImageError(),
          )
        : Image.network(
            item.gambar,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _buildImageError(),
          );

    return SizedBox(height: 160, width: double.infinity, child: imageWidget);
  }

  Widget _buildImageError() {
    return Container(height: 160, color: Colors.grey, child: Icon(Icons.error));
  }
}
