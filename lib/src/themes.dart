import 'package:flutter/material.dart';

abstract class ThemeConstants{

  ThemeConstants._();

  static const kThemeModeSystem = 'theme_mode_system';
  static const kThemeModeLight = 'theme_mode_light';
  static const kThemeModeDark = 'theme_mode_dark';

  static const kDefaultThemeMode = ThemeMode.system;

}