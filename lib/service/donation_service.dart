import 'package:cloud_firestore/cloud_firestore.dart';

class DonationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// SIMPAN DONASI KE FIREBASE
  Future<void> insertDonasi({
    required String userId,
    required String jenis,
    required int nominal,
  }) async {
    try {
      print("💾 Menyimpan donasi untuk user: $userId");

      await _firestore.collection("donasi").add({
        "user_id": userId,
        "jenis": jenis,
        "nominal": nominal,
        "tanggal": DateTime.now().toString(),
      });

      print("✅ Donasi berhasil disimpan ke Firebase");
    } catch (e) {
      print("❌ Error menyimpan donasi: $e");
      rethrow;
    }
  }

  /// AMBIL DONASI USER SATU KALI
  Future<List<Map<String, dynamic>>> getDonasiUser(String userId) async {
    try {
      print("🔍 Mengambil donasi untuk user: $userId");

      final snapshot = await _firestore
          .collection("donasi")
          .where("user_id", isEqualTo: userId)
          .get();

      final data = snapshot.docs.map((doc) {
        return {
          "id": doc.id,
          "user_id": doc["user_id"],
          "jenis": doc["jenis"],
          "nominal": doc["nominal"],
          "tanggal": doc["tanggal"],
        };
      }).toList();

      // Sort di Dart (descending by tanggal)
      data.sort(
        (a, b) => b["tanggal"].toString().compareTo(a["tanggal"].toString()),
      );

      print("📊 ${data.length} donasi ditemukan");
      return data;
    } catch (e) {
      print("❌ Error mengambil donasi: $e");
      rethrow;
    }
  }

  /// REAL-TIME LISTENER UNTUK DONASI USER
  Stream<List<Map<String, dynamic>>> streamDonasiUser(String userId) {
    try {
      print("📡 Membuka real-time stream untuk user: $userId");

      return _firestore
          .collection("donasi")
          .where("user_id", isEqualTo: userId)
          .snapshots()
          .map((snapshot) {
            final data = snapshot.docs.map((doc) {
              return {
                "id": doc.id,
                "user_id": doc["user_id"],
                "jenis": doc["jenis"],
                "nominal": doc["nominal"],
                "tanggal": doc["tanggal"],
              };
            }).toList();

            // Sort di Dart (descending by tanggal)
            data.sort(
              (a, b) =>
                  b["tanggal"].toString().compareTo(a["tanggal"].toString()),
            );

            print("📡 Stream update: ${data.length} donasi");
            return data;
          });
    } catch (e) {
      print("❌ Error membuka stream: $e");
      rethrow;
    }
  }

  /// HAPUS DONASI (OPTIONAL)
  Future<void> deleteDonasi(String docId) async {
    try {
      await _firestore.collection("donasi").doc(docId).delete();
      print("🗑️ Donasi berhasil dihapus");
    } catch (e) {
      print("❌ Error menghapus donasi: $e");
      rethrow;
    }
  }

  /// UPDATE DONASI (OPTIONAL)
  Future<void> updateDonasi(
    String docId, {
    required String jenis,
    required int nominal,
  }) async {
    try {
      await _firestore.collection("donasi").doc(docId).update({
        "jenis": jenis,
        "nominal": nominal,
        "tanggal": DateTime.now().toString(),
      });
      print("✏️ Donasi berhasil diupdate");
    } catch (e) {
      print("❌ Error mengupdate donasi: $e");
      rethrow;
    }
  }
}
