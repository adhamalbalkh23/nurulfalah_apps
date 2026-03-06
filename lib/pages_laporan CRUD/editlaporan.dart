import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nurulfalah_apps/database/sqflite.dart';

class EditLaporanPage extends StatelessWidget {
  final Map data;

  EditLaporanPage({super.key, required this.data});

  final judul = TextEditingController();
  final deskripsi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    judul.text = data["judul"];
    deskripsi.text = data["deskripsi"];

    return Scaffold(
      appBar: AppBar(title: Text("Edit Laporan")),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.file(File(data["gambar"]), height: 150),

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
                await DbHelper.updateLaporan(
                  data["id"],
                  judul.text,
                  deskripsi.text,
                );

                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
