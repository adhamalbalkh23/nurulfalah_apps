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
  static const String _userId = "user_id";

  // =========================
  // LOGIN
  // =========================

  Future<void> storingIsLogin(bool isLogin) async {
    await _preferences.setBool(_isLogin, isLogin);
  }

  static Future<bool?> getIsLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLogin);
  }

  // =========================
  // ROLE
  // =========================

  Future<void> storingRole(String role) async {
    await _preferences.setString(_role, role);
  }

  static Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_role);
  }

  // =========================
  // NAMA
  // =========================

  Future<void> storingNama(String nama) async {
    await _preferences.setString(_nama, nama);
  }

  static Future<String?> getNama() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_nama);
  }

  // =========================
  // USER ID (SUDAH DIUBAH KE STRING)
  // =========================

  Future<void> storingUserId(String id) async {
    await _preferences.setString(_userId, id);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userId);
  }

  // =========================
  // LOGOUT
  // =========================

  Future<void> deleteIsLogin() async {
    await _preferences.remove(_isLogin);
  }
}
