import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> setFirstTime({required bool value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', value);
  }

  static Future<bool> isFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime') ?? true; 
  }
}
