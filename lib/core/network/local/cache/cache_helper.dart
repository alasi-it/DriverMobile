import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  /// OBJECT FROM PACKAGE
  static late SharedPreferences sharedPreferences;

  /// GET INSTANCE FROM SHARED PREFERENCES
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();

    /// SET DEFAULT VALUES
    if (await get('theme') == null) await save('theme', 'light');
    if (await get('first_use') == null) await save('first_use', true);
  }

  /// SAVE DATA IN CACHE
  static Future<bool> save(String key, dynamic value) async {
    switch (value.runtimeType) {
      case const (String):
        return await sharedPreferences.setString(key, value);
      case const (int):
        return await sharedPreferences.setInt(key, value);
      case const (bool):
        return await sharedPreferences.setBool(key, value);
      case const (double):
        return await sharedPreferences.setDouble(key, value);
      default:
        return false;
    }
  }

  /// GET DATA FROM CACHE
  static dynamic get(String key) {
    return sharedPreferences.get(key);
  }

  /// REMOVE DATA FROM CACHE BY KEY
  static Future<bool> remove(String key) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> removeAll() async {
    return await sharedPreferences.clear();
  }

  /// SAVE DATA IN CACHE
  static Future<bool> map(Map<String, dynamic> data) async {
    try {
      data.forEach((key, value) async {
        switch (value.runtimeType) {
          case const (String):
            await sharedPreferences.setString(key, value);
            break;
          case const (int):
            await sharedPreferences.setInt(key, value);
            break;
          case const (bool):
            await sharedPreferences.setBool(key, value);
            break;
          case const (double):
            await sharedPreferences.setDouble(key, value);
            break;
          default:
            break;
        }
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
