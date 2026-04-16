import 'package:cloud_firestore/cloud_firestore.dart';

class DonasiModel {
  final String id;
  final String userId;
  final String jenis;
  final int nominal;
  final DateTime tanggal;

  DonasiModel({
    required this.id,
    required this.userId,
    required this.jenis,
    required this.nominal,
    required this.tanggal,
  });

  factory DonasiModel.fromMap(Map<String, dynamic> map, String docId) {
    return DonasiModel(
      id: docId,
      userId: map['user_id'],
      jenis: map['jenis'],
      nominal: map['nominal'],
      tanggal: (map['tanggal'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "user_id": userId,
      "jenis": jenis,
      "nominal": nominal,
      "tanggal": tanggal,
    };
  }
}
