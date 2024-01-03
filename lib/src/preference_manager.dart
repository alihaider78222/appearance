import 'package:shared_preferences/shared_preferences.dart';
import 'package:appearance/src/constants.dart';
import 'package:appearance/src/themes.dart';

class PreferenceManager {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  PreferenceManager(this._sharedPreference);

  Future<void> reload() => _sharedPreference.reload();

  // Theme mode:---------------------------------------------------
  String get themeMode =>
      _sharedPreference.getString(Constants.kThemeModeKey) ??
      Constants.kThemeModeKey;
  set themeMode(String? value) => _sharedPreference.setString(
      Constants.kThemeModeKey, value ?? ThemeConstants.kThemeModeSystem);
}
