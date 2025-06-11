import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> setFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
  }

  static Future<bool> checkFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTime') ?? true; 
  }
}
