import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String nama;
  final String email;
  final String role;

  UserModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.role,
  });

  /// DARI FIRESTORE → MODEL
  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      id: docId,
      nama: map['nama'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'user',
    );
  }

  /// MODEL → FIRESTORE
  Map<String, dynamic> toMap() {
    return {"nama": nama, "email": email, "role": role};
  }

  /// COPY WITH (opsional, biar fleksibel)
  UserModel copyWith({String? id, String? nama, String? email, String? role}) {
    return UserModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }
}
