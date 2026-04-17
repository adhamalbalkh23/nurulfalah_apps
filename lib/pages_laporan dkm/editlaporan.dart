import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nurulfalah_apps/service/laporan_service.dart';
import 'package:nurulfalah_apps/models/laporan_model.dart';

class EditLaporanPage extends StatefulWidget {
  final dynamic data; // Bisa Map atau LaporanModel

  const EditLaporanPage({super.key, required this.data});

  @override
  State<EditLaporanPage> createState() => _EditLaporanPageState();
}

class _EditLaporanPageState extends State<EditLaporanPage> {
  final judul = TextEditingController();
  final deskripsi = TextEditingController();

  late String laporanId;
  late String oldImageUrl;
  late bool isLocal;
  File? newImageFile;
  final picker = ImagePicker();
  final LaporanService _laporanService = LaporanService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    // Handle both Map (from SQLite) and LaporanModel (from Firebase)
    if (widget.data is LaporanModel) {
      final laporan = widget.data as LaporanModel;
      laporanId = laporan.id;
      judul.text = laporan.judul;
      deskripsi.text = laporan.deskripsi;
      oldImageUrl = laporan.gambar;
      isLocal = laporan.isLocal;
    } else {
      final map = widget.data as Map;
      laporanId = map["id"].toString();
      judul.text = map["judul"];
      deskripsi.text = map["deskripsi"];
      oldImageUrl = map["gambar"];
      isLocal = true;
    }
  }

  Future pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (picked != null) {
      setState(() {
        newImageFile = File(picked.path);
      });
    }
  }

  Widget _buildImagePreview() {
    if (newImageFile != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(newImageFile!, fit: BoxFit.cover),
      );
    }

    if (oldImageUrl.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(oldImageUrl, fit: BoxFit.cover),
      );
    } else if (oldImageUrl.length > 100) {
      // Asumsi jika string panjang dan bukan URL/Path, maka itu Base64
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(base64Decode(oldImageUrl), fit: BoxFit.cover),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.file(File(oldImageUrl), fit: BoxFit.cover),
      );
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
        title: Text("Edit Laporan"),
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
                child: _buildImagePreview(),
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

            /// Tombol Update dan Delete
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _isLoading ? null : _updateLaporan,
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
                          : Text("Update", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _isLoading ? null : _deleteLaporan,
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
                          : Text("Hapus", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateLaporan() async {
    if (judul.text.isEmpty || deskripsi.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Isi semua field terlebih dahulu")),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      print("🔄 Mulai update laporan...");
      await _laporanService
          .updateLaporan(
            laporanId: laporanId,
            judul: judul.text,
            deskripsi: deskripsi.text,
            imageFile: newImageFile,
            oldImageUrl: oldImageUrl,
            isLocal: isLocal,
          )
          .timeout(
            const Duration(seconds: 60),
            onTimeout: () {
              throw "Timeout: Proses update terlalu lama";
            },
          );

      if (mounted) {
        print("✅ Laporan berhasil diupdate");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Laporan berhasil diupdate"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      print("❌ Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteLaporan() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hapus Laporan"),
          content: Text("Apakah Anda yakin ingin menghapus laporan ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() => _isLoading = true);
                try {
                  print("🔄 Mulai hapus laporan...");
                  await _laporanService
                      .deleteLaporan(
                        laporanId: laporanId,
                        imageUrl: oldImageUrl,
                        isLocal: isLocal,
                      )
                      .timeout(
                        const Duration(seconds: 30),
                        onTimeout: () {
                          throw "Timeout: Proses delete terlalu lama";
                        },
                      );

                  if (mounted) {
                    print("✅ Laporan berhasil dihapus");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Laporan berhasil dihapus"),
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
              child: Text("Hapus", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
