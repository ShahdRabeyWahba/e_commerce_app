import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String token) async {
    await _prefs.setString('token', token);
  }

  static String? getToken() {
    return _prefs.getString('token');
  }

  static Future<void> removeToken() async {
    await _prefs.remove('token');
  }

  static Future<void> saveUser(String name, String email, {String? phone, String? address}) async {
    await _prefs.setString('userName', name);
    await _prefs.setString('userEmail', email);
    if (phone != null) await _prefs.setString('userPhone', phone);
    if (address != null) await _prefs.setString('userAddress', address);
  }

  static String? getUserName() {
    return _prefs.getString('userName');
  }

  static String? getUserEmail() {
    return _prefs.getString('userEmail');
  }

  static String? getUserPhone() {
    return _prefs.getString('userPhone');
  }

  static String? getUserAddress() {
    return _prefs.getString('userAddress');
  }
}
