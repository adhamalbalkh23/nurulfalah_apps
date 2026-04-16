import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseDebugHelper {
  /// Test Firebase Firestore connection
  static Future<bool> testFirestoreConnection() async {
    try {
      print("🔄 Testing Firestore connection...");

      // Coba read collection
      final result = await FirebaseFirestore.instance
          .collection('laporan')
          .limit(1)
          .get()
          .timeout(const Duration(seconds: 10));

      print(
        "✅ Firestore connection OK - Found ${result.docs.length} documents",
      );
      return true;
    } catch (e) {
      print("❌ Firestore connection error: $e");
      return false;
    }
  }

  /// Test Firebase Storage connection
  static Future<bool> testStorageConnection() async {
    try {
      print("🔄 Testing Firebase Storage connection...");

      // Coba list files
      final result = await FirebaseStorage.instance
          .ref('laporan')
          .listAll()
          .timeout(const Duration(seconds: 10));

      print("✅ Storage connection OK - Found ${result.items.length} files");
      return true;
    } catch (e) {
      print("❌ Storage connection error: $e");
      return false;
    }
  }

  /// Test if laporan collection exists and writable
  static Future<bool> testLaporanCollectionWritable() async {
    try {
      print("🔄 Testing if laporan collection is writable...");

      // Try to create a test document
      final docRef = await FirebaseFirestore.instance.collection('laporan').add(
        {'test': true, 'timestamp': DateTime.now()},
      );

      print("✅ Collection writable! Test doc ID: ${docRef.id}");

      // Delete test document
      await docRef.delete();
      print("✅ Cleanup complete");

      return true;
    } catch (e) {
      print("❌ Collection write error: $e");
      return false;
    }
  }

  /// Run all diagnostics
  static Future<Map<String, bool>> runDiagnostics() async {
    print("\n╔════════════════════════════════════╗");
    print("║  FIREBASE DIAGNOSTICS              ║");
    print("╚════════════════════════════════════╝\n");

    final results = <String, bool>{};

    results['Firestore'] = await testFirestoreConnection();
    results['Storage'] = await testStorageConnection();
    results['Laporan Collection'] = await testLaporanCollectionWritable();

    print("\n╔════════════════════════════════════╗");
    print("║  DIAGNOSTICS RESULT                ║");
    print("╚════════════════════════════════════╝\n");

    results.forEach((key, value) {
      print("${value ? '✅' : '❌'} $key");
    });

    final allOk = results.values.every((v) => v);
    print("\n${allOk ? '✅ ALL SYSTEMS OK' : '❌ SOME SYSTEMS DOWN'}\n");

    return results;
  }
}
