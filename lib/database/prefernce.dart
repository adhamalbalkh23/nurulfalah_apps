import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHandler {
  static final PreferenceHandler _instance = PreferenceHandler._internal();
  late SharedPreferences _preferences;

  factory PreferenceHandler() => _instance;

  PreferenceHandler._internal();

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // KEY
  static const String _isLogin = 'isLogin';
  static const String _role = 'role';
  static const String _nama = 'nama';
  static const String _userId = "userId";

  // SIMPAN LOGIN
  Future<void> storingIsLogin(bool isLogin) async {
    _preferences.setBool(_isLogin, isLogin);
  }

  // AMBIL LOGIN
  static Future<bool?> getIsLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLogin);
  }

  // SIMPAN ROLE
  Future<void> storingRole(String role) async {
    _preferences.setString(_role, role);
  }

  // AMBIL ROLE
  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_role);
  }

  // SIMPAN NAMA
  Future<void> storingNama(String nama) async {
    _preferences.setString(_nama, nama);
  }

  // AMBIL NAMA
  static Future<String?> getNama() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nama);
  }

  // LOGOUT
  Future<void> deleteIsLogin() async {
    await _preferences.remove(_isLogin);
  }

  // UserId
  Future<void> storingUserId(int id) async {
    _preferences.setInt(_userId, id);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userId);
  }
}
