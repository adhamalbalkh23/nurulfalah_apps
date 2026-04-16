import 'package:cloud_firestore/cloud_firestore.dart';

class LaporanModel {
  final String id;
  final String judul;
  final String deskripsi;
  final String gambar;
  final DateTime tanggal;
  final bool isLocal;

  LaporanModel({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.gambar,
    required this.tanggal,
    this.isLocal = false,
  });

  /// DARI FIRESTORE → MODEL
  factory LaporanModel.fromMap(Map<String, dynamic> map, String docId) {
    return LaporanModel(
      id: docId,
      judul: map['judul'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      gambar: map['gambar'] ?? '',
      tanggal: map['tanggal'] is Timestamp
          ? (map['tanggal'] as Timestamp).toDate()
          : DateTime.parse(map['tanggal'] ?? DateTime.now().toString()),
      isLocal: false,
    );
  }

  factory LaporanModel.fromSqliteMap(Map<String, dynamic> map) {
    return LaporanModel(
      id: map['id'].toString(),
      judul: map['judul'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      gambar: map['gambar'] ?? '',
      tanggal: DateTime.parse(map['tanggal'] ?? DateTime.now().toString()),
      isLocal: true,
    );
  }

  /// MODEL → FIRESTORE
  Map<String, dynamic> toMap() {
    return {
      "judul": judul,
      "deskripsi": deskripsi,
      "gambar": gambar,
      "tanggal": Timestamp.fromDate(tanggal),
    };
  }

  /// COPY WITH (opsional, biar fleksibel)
  LaporanModel copyWith({
    String? id,
    String? judul,
    String? deskripsi,
    String? gambar,
    DateTime? tanggal,
    bool? isLocal,
  }) {
    return LaporanModel(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      deskripsi: deskripsi ?? this.deskripsi,
      gambar: gambar ?? this.gambar,
      tanggal: tanggal ?? this.tanggal,
      isLocal: isLocal ?? this.isLocal,
    );
  }
}
