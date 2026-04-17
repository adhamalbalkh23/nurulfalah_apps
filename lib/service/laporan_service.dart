import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nurulfalah_apps/database/sqflite.dart';
import 'package:nurulfalah_apps/models/laporan_model.dart';

class LaporanService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  static bool _firebaseDown = false;

  /// Helper untuk mengonversi File ke Base64 (tanpa kompresi tambahan di sini, 
  /// karena sebaiknya dilakukan saat pickImage untuk efisiensi memory)
  Future<String> _fileToBase64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  Future<void> addLaporan({
    required String judul,
    required String deskripsi,
    required File imageFile,
  }) async {
    try {
      print("Mulai simpan laporan dengan judul: $judul");

      if (_firebaseDown) {
        print("Firebase sedang down, simpan ke SQLite");
        await DbHelper.insertLaporan(judul, deskripsi, imageFile.path);
        print("Laporan disimpan ke SQLite (offline mode)");
        return;
      }

      // Konversi gambar ke Base64
      final base64Image = await _fileToBase64(imageFile);
      print("Gambar berhasil dikonversi ke Base64");

      await _firestore.collection('laporan').add({
        'judul': judul,
        'deskripsi': deskripsi,
        'gambar': base64Image,
        'tanggal': Timestamp.fromDate(DateTime.now()),
      }).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw TimeoutException("Firestore save timeout");
        },
      );

      print("Laporan berhasil disimpan ke Firestore");
      _firebaseDown = false;
    } on FirebaseException catch (e) {
      print("Firebase Error saat add laporan: ${e.code} - ${e.message}");
      print("Fallback ke SQLite...");

      try {
        await DbHelper.insertLaporan(judul, deskripsi, imageFile.path);
        print("Laporan disimpan ke SQLite (fallback mode)");
        _firebaseDown = true;
      } catch (sqliteError) {
        throw "Firebase error + SQLite fallback juga gagal: $sqliteError";
      }
    } on TimeoutException catch (e) {
      print("Timeout: $e");
      print("Fallback ke SQLite...");

      try {
        await DbHelper.insertLaporan(judul, deskripsi, imageFile.path);
        print("Laporan disimpan ke SQLite (timeout fallback)");
        _firebaseDown = true;
      } catch (sqliteError) {
        throw "Timeout + SQLite fallback gagal: $sqliteError";
      }
    } catch (e) {
      print("Error saat add laporan: $e");
      throw "Error: $e";
    }
  }

  Future<List<LaporanModel>> getLaporan() async {
    final sqliteLaporan = await _getSqliteLaporan();

    try {
      print("Mengambil data laporan dari Firestore");

      final snapshot = await _firestore
          .collection('laporan')
          .orderBy('tanggal', descending: true)
          .get()
          .timeout(const Duration(seconds: 15));

      final firestoreLaporan = snapshot.docs
          .map((doc) => LaporanModel.fromMap(doc.data(), doc.id))
          .toList();

      final mergedLaporan = [...firestoreLaporan, ...sqliteLaporan]
        ..sort((a, b) => b.tanggal.compareTo(a.tanggal));

      print(
        "Berhasil mengambil ${firestoreLaporan.length} laporan dari Firestore dan ${sqliteLaporan.length} laporan dari SQLite",
      );
      _firebaseDown = false;
      return mergedLaporan;
    } catch (e) {
      print("Firebase error, fallback ke SQLite: $e");
      _firebaseDown = true;
      return sqliteLaporan;
    }
  }

  Future<void> updateLaporan({
    required String laporanId,
    required String judul,
    required String deskripsi,
    File? imageFile,
    String? oldImageUrl,
    bool isLocal = false,
  }) async {
    if (isLocal) {
      await DbHelper.updateLaporan(
        int.parse(laporanId),
        judul,
        deskripsi,
        gambar: imageFile?.path,
      );
      print("Laporan lokal berhasil diupdate");
      return;
    }

    try {
      print("Mulai update laporan dengan ID: $laporanId");

      Map<String, dynamic> updateData = {
        'judul': judul,
        'deskripsi': deskripsi,
      };

      if (imageFile != null) {
        // Jika ada gambar baru, konversi ke Base64
        final base64Image = await _fileToBase64(imageFile);
        updateData['gambar'] = base64Image;
        print("Gambar baru berhasil dikonversi ke Base64");
        
        // Opsional: Hapus gambar lama dari Firebase Storage jika format lama adalah URL
        if (oldImageUrl != null && oldImageUrl.startsWith('http')) {
          try {
            final ref = FirebaseStorage.instance.refFromURL(oldImageUrl);
            await ref.delete();
            print("Gambar lama di Storage berhasil dihapus");
          } catch (e) {
            print("Gagal menghapus gambar lama dari Storage (mungkin sudah tidak ada): $e");
          }
        }
      }

      await _firestore.collection('laporan').doc(laporanId).update(updateData);

      print("Laporan berhasil diupdate");
    } on FirebaseException catch (e) {
      print("Firebase Error saat update laporan: ${e.message}");
      rethrow;
    } catch (e) {
      print("Error saat update laporan: $e");
      rethrow;
    }
  }

  Future<void> deleteLaporan({
    required String laporanId,
    required String imageUrl,
    bool isLocal = false,
  }) async {
    if (isLocal) {
      await DbHelper.deleteLaporan(int.parse(laporanId));
      print("Laporan lokal berhasil dihapus");
      return;
    }

    try {
      print("Mulai hapus laporan dengan ID: $laporanId");

      // Jika format lama adalah URL, hapus dari Storage
      if (imageUrl.startsWith('http')) {
        try {
          final ref = FirebaseStorage.instance.refFromURL(imageUrl);
          await ref.delete();
          print("Gambar di Storage berhasil dihapus");
        } catch (e) {
          print("Gagal menghapus gambar dari Storage: $e");
        }
      }

      await _firestore.collection('laporan').doc(laporanId).delete();

      print("Laporan berhasil dihapus");
    } on FirebaseException catch (e) {
      print("Firebase Error saat delete laporan: ${e.message}");
      rethrow;
    } catch (e) {
      print("Error saat delete laporan: $e");
      rethrow;
    }
  }

  Stream<List<LaporanModel>> getLaporanStream() {
    return _firestore
        .collection('laporan')
        .orderBy('tanggal', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => LaporanModel.fromMap(doc.data(), doc.id))
              .toList();
        });
  }

  Future<List<LaporanModel>> _getSqliteLaporan() async {
    print("Mengambil data laporan dari SQLite");
    final data = await DbHelper.getLaporan();
    return data.map((item) => LaporanModel.fromSqliteMap(item)).toList();
  }
}
