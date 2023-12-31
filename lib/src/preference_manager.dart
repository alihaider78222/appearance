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

  // Font Family:---------------------------------------------------
  String get fontFamily =>
      _sharedPreference.getString(Constants.kFontFamilyKey) ??
      Constants.kDefaultFontFamily;
  set fontFamily(String value) =>
      _sharedPreference.setString(Constants.kFontFamilyKey, value);

// AskBeforeExit Dialog:---------------------------------------------------
  bool get askBeforeExit =>
      _sharedPreference.getBool(Constants.kAskBeforeExit) ?? false;
  set askBeforeExit(bool value) =>
      _sharedPreference.setBool(Constants.kAskBeforeExit, value);

// OnBoarding Screen:---------------------------------------------------
  bool get onboardingScreen =>
      _sharedPreference.getBool(Constants.kOnboardingScreen) ?? true;
  set onboardingScreen(bool value) =>
      _sharedPreference.setBool(Constants.kOnboardingScreen, value);

  // Language:---------------------------------------------------
  String? get currentLanguage =>
      _sharedPreference.getString(Constants.currentLanguage);
  Future<void> changeLanguage(String language) =>
      _sharedPreference.setString(Constants.currentLanguage, language);
}
