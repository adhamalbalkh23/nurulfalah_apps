import 'package:nurulfalah_apps/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();

    return openDatabase(
      join(dbPath, 'nurulfalah.db'),

      version: 8,

      onCreate: (db, version) async {
        /// TABEL USER
        await db.execute('''
        CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT,
        email TEXT,
        password TEXT,
        role TEXT
        )
        ''');

        /// ADMIN MASJID DEFAULT
        await db.insert("user", {
          "email": "admin@masjid.com",
          "password": "123456",
          "role": "admin",
        });

        /// TABEL DONASI
        await db.execute('''
        CREATE TABLE donasi(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        jenis TEXT,
        nominal INTEGER,
        tanggal TEXT
        )
        ''');

        /// TABEL LAPORAN KEGIATAN
        await db.execute('''
        CREATE TABLE laporan(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        judul TEXT,
        deskripsi TEXT,
        gambar TEXT,
        tanggal TEXT
        )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute("DROP TABLE IF EXISTS user");
          await db.execute("DROP TABLE IF EXISTS donasi");
          await db.execute("DROP TABLE IF EXISTS laporan");
        }
      },
    );
  }

  // REGISTER USER

  static Future<void> registerUser(
    String nama,
    String email,
    String password,
  ) async {
    final dbs = await db();

    await dbs.insert("user", {
      "nama": nama.trim(),
      "email": email.trim(),
      "password": password.trim(),
      "role": "user",
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // LOGIN USER / ADMIN

  static Future<Map<String, dynamic>?> loginUser(
    String email,
    String password,
  ) async {
    final dbs = await db();

    final result = await dbs.query(
      "user",
      where: "email=? AND password=?",
      whereArgs: [email.trim(), password.trim()],
    );

    if (result.isNotEmpty) {
      return result.first;
    }

    return null;
  }

  // SIMPAN DONASI

  static Future<void> insertDonasi(
    int userId,
    String jenis,
    int nominal,
  ) async {
    final dbs = await db();

    await dbs.insert("donasi", {
      "user_id": userId,
      "jenis": jenis,
      "nominal": nominal,
      "tanggal": DateTime.now().toString(),
    });
  }

  // AMBIL RIWAYAT DONASI

  static Future<List<Map<String, dynamic>>> getDonasiUser(int userId) async {
    final dbs = await db();

    return dbs.query(
      "donasi",
      where: "user_id=?",
      whereArgs: [userId],
      orderBy: "id DESC",
    );
  }

  // TAMBAH LAPORAN KEGIATAN

  static Future<void> insertLaporan(
    String judul,
    String deskripsi,
    String gambar,
  ) async {
    final dbs = await db();

    await dbs.insert("laporan", {
      "judul": judul,
      "deskripsi": deskripsi,
      "gambar": gambar,
      "tanggal": DateTime.now().toString(),
    });
  }

  // AMBIL LAPORAN KEGIATAN

  static Future<List<Map<String, dynamic>>> getLaporan() async {
    final dbs = await db();

    return dbs.query("laporan", orderBy: "id DESC");
  }

  // UPDATE LAPORAN

  static Future<void> updateLaporan(
    int id,
    String judul,
    String deskripsi,
  ) async {
    final dbs = await db();

    await dbs.update(
      "laporan",
      {"judul": judul, "deskripsi": deskripsi},
      where: "id=?",
      whereArgs: [id],
    );
  }

  // HAPUS LAPORAN

  static Future<void> deleteLaporan(int id) async {
    final dbs = await db();

    await dbs.delete("laporan", where: "id=?", whereArgs: [id]);
  }
}
