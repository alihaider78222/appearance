import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  late SharedPreferences _preferences;

  // Private constructor to prevent multiple instances
  SharedPreferencesManager._();

  // Getter for the singleton instance
  static SharedPreferencesManager get instance {
    _instance ??= SharedPreferencesManager._();
    return _instance!;
  }

  // Initialize SharedPreferences
  Future<void> init({SharedPreferences? preferences}) async {
    if (preferences != null) {
      _preferences = preferences;
    } else {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  SharedPreferences get preference => _preferences;
}
