import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  late SharedPreferences _preferences;

  // Private constructor to prevent multiple instances
  SharedPreferencesManager._();

  // Getter for the singleton instance
  static SharedPreferencesManager get instance {
    if (_instance == null) {
      _instance = SharedPreferencesManager._();
    }
    return _instance!;
  }

  // Initialize SharedPreferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  SharedPreferences get preference => _preferences;
}
