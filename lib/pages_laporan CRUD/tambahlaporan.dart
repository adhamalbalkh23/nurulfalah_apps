import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nurulfalah_apps/database/sqflite.dart';

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

  Future pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Laporan")),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: imageFile == null
                    ? Center(child: Text("Pilih Foto"))
                    : Image.file(imageFile!, fit: BoxFit.cover),
              ),
            ),

            TextField(
              controller: judul,
              decoration: InputDecoration(labelText: "Judul"),
            ),

            TextField(
              controller: deskripsi,
              decoration: InputDecoration(labelText: "Deskripsi"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await DbHelper.insertLaporan(
                  judul.text,
                  deskripsi.text,
                  imageFile!.path,
                );

                Navigator.pop(context);
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}
