import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nurulfalah_apps/database/sqflite.dart';
import 'package:nurulfalah_apps/service/laporan_service.dart';
import 'dart:io';

class TambahLaporanPage extends StatefulWidget {
  const TambahLaporanPage({super.key});

  @override
  State<TambahLaporanPage> createState() => _TambahLaporanPageState();
}

class _TambahLaporanPageState extends State<TambahLaporanPage> {
  final judul = TextEditingController();
  final deskripsi = TextEditingController();

  File? imageFile;
  final picker = ImagePicker();
  final LaporanService _laporanService = LaporanService();
  bool _isLoading = false;

  Future pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  @override
  void dispose() {
    judul.dispose();
    deskripsi.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Laporan Kegiatan"),
        backgroundColor: Colors.green,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Upload Foto
            Text(
              "Foto Kegiatan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),

                child: imageFile == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                          SizedBox(height: 8),
                          Text(
                            "Tambah Foto",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(imageFile!, fit: BoxFit.cover),
                      ),
              ),
            ),

            SizedBox(height: 20),

            /// Judul
            Text(
              "Judul Kegiatan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            TextField(
              controller: judul,
              decoration: InputDecoration(
                hintText: "Masukkan judul kegiatan",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 20),

            /// Deskripsi
            Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold)),

            SizedBox(height: 8),

            TextField(
              controller: deskripsi,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Masukkan deskripsi kegiatan",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(height: 30),

            /// Tombol Simpan
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _isLoading
                    ? null
                    : () async {
                        if (imageFile == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Pilih foto terlebih dahulu"),
                            ),
                          );
                          return;
                        }

                        if (judul.text.isEmpty || deskripsi.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Isi semua field terlebih dahulu"),
                            ),
                          );
                          return;
                        }

                        setState(() => _isLoading = true);
                        try {
                          print("🔄 Mulai upload laporan...");
                          await _laporanService
                              .addLaporan(
                                judul: judul.text,
                                deskripsi: deskripsi.text,
                                imageFile: imageFile!,
                              )
                              .timeout(
                                const Duration(seconds: 60),
                                onTimeout: () {
                                  throw "Timeout: Proses upload terlalu lama";
                                },
                              );

                          if (mounted) {
                            print("✅ Laporan berhasil disimpan");
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Laporan berhasil disimpan"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          print("❌ Error: $e");
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Gagal: $e"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() => _isLoading = false);
                          }
                        }
                      },
                child: _isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                          strokeWidth: 3,
                        ),
                      )
                    : Text("Simpan Laporan", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
