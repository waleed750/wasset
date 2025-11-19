import 'package:shared_preferences/shared_preferences.dart';

class wassetSharedPreferences {
  wassetSharedPreferences();

  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static Future<bool> setString(String key, String value) async =>
      instance.setString(key, value);

  // set and get token
  static Future<bool> setToken(String value) async =>
      instance.setString('token', value);

  static String? getToken() => instance.getString('token');

  static void removeToken() => instance.remove('token');

  static Future<void> clear() => instance.clear();
}
