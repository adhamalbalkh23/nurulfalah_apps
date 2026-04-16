import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// REGISTER
  Future<UserModel?> register({
    required String nama,
    required String email,
    required String password,
    String role = "user",
  }) async {
    try {
      print("🔄 Mulai registrasi untuk email: $email (role: $role)");

      // buat akun auth
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user != null) {
        print("✅ Akun Firebase berhasil dibuat: ${user.uid}");

        // simpan ke firestore dengan role yang dipilih
        await _firestore.collection("users").doc(user.uid).set({
          "nama": nama,
          "email": email,
          "role": role,
        });

        print(
          "✅ Data user berhasil disimpan ke Firestore dengan role: '$role'",
        );

        return UserModel(id: user.uid, nama: nama, email: email, role: role);
      }
    } on FirebaseAuthException catch (e) {
      print("❌ Firebase Auth Error [${e.code}]: ${e.message}");
      rethrow;
    } on FirebaseException catch (e) {
      print("❌ Firebase Error: ${e.message}");
      rethrow;
    } catch (e) {
      print("❌ Unexpected Error in Register: $e");
      rethrow;
    }
    return null;
  }

  /// LOGIN
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      print("🔄 Mulai login untuk email: $email");

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      print("✅ Autentikasi Firebase berhasil: ${user?.uid}");

      if (user != null) {
        // ambil data user dari firestore dengan force refresh
        final doc = await _firestore
            .collection("users")
            .doc(user.uid)
            .get(const GetOptions(source: Source.server));
        print("📊 Status Firestore: exists=${doc.exists}");

        final data = doc.data();
        print("📋 Raw data dari Firestore: $data");

        if (data != null) {
          print("✅ Data user ditemukan di Firestore");
          final roleFromFirestore = data["role"] ?? "user";
          print(
            "🔐 Role dari Firestore: '$roleFromFirestore' (Type: ${roleFromFirestore.runtimeType})",
          );

          return UserModel(
            id: user.uid,
            nama: data["nama"] ?? "User",
            email: data["email"] ?? email,
            role: roleFromFirestore,
          );
        } else {
          // Jika data tidak ada di Firestore, buat data default
          print(
            "⚠️ Data user tidak ditemukan di Firestore, membuat data default",
          );
          await _firestore.collection("users").doc(user.uid).set({
            "nama": email.split("@")[0],
            "email": email,
            "role": "user",
          });

          return UserModel(
            id: user.uid,
            nama: email.split("@")[0],
            email: email,
            role: "user",
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      print("❌ Firebase Auth Error [${e.code}]: ${e.message}");
      rethrow;
    } on FirebaseException catch (e) {
      print("❌ Firebase Error: ${e.message}");
      rethrow;
    } catch (e) {
      print("❌ Unexpected Error in Login: $e");
      rethrow;
    }
    return null;
  }

  /// LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  /// GET CURRENT USER
  Future<UserModel?> getCurrentUser() async {
    final user = _auth.currentUser;

    if (user != null) {
      final doc = await _firestore.collection("users").doc(user.uid).get();

      final data = doc.data();

      if (data != null) {
        return UserModel(
          id: user.uid,
          nama: data["nama"],
          email: data["email"],
          role: data["role"],
        );
      }
    }
    return null;
  }

  /// DIAGNOSTIC: CEK SEMUA USER DI FIRESTORE
  Future<void> debugPrintAllUsers() async {
    try {
      print("\n🔍 === DIAGNOSTIC: CEK SEMUA USER DI FIRESTORE ===");
      final snapshot = await _firestore.collection("users").get();

      print("📊 Total users di Firestore: ${snapshot.docs.length}");

      for (var doc in snapshot.docs) {
        final data = doc.data();
        print("\n👤 UID: ${doc.id}");
        print("   - Nama: ${data['nama']}");
        print("   - Email: ${data['email']}");
        print(
          "   - Role: '${data['role']}' (Type: ${data['role'].runtimeType})",
        );
        print("   - Admin? ${data['role'] == 'admin'}");
      }
      print("\n=== END DIAGNOSTIC ===\n");
    } catch (e) {
      print("❌ Error saat diagnostic: $e");
    }
  }

  /// DIAGNOSTIC: CEK USER SAAT INI
  Future<void> debugPrintCurrentUser() async {
    try {
      print("\n🔍 === DIAGNOSTIC: CEK USER SAAT INI ===");
      final user = _auth.currentUser;

      if (user == null) {
        print("❌ Tidak ada user yang login");
        return;
      }

      print("👤 UID: ${user.uid}");
      print("   - Email: ${user.email}");

      final doc = await _firestore.collection("users").doc(user.uid).get();

      if (!doc.exists) {
        print("   - ❌ Document tidak ada di Firestore");
        return;
      }

      final data = doc.data()!;
      print("   - Nama: ${data['nama']}");
      print("   - Email: ${data['email']}");
      print("   - Role: '${data['role']}' (Type: ${data['role'].runtimeType})");
      print("   - Admin? ${data['role'] == 'admin'}");
      print("\n=== END DIAGNOSTIC ===\n");
    } catch (e) {
      print("❌ Error saat diagnostic: $e");
    }
  }
}
