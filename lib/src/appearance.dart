import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../appearance.dart';
import 'preference_manager.dart';
import 'themes.dart';

/// Appearance
class Appearance extends InheritedWidget {
  final ThemeMode mode;
  final ValueChanged<ThemeMode> setMode;

  const Appearance({
    required this.mode,
    required this.setMode,
    required Widget child,
    Key? key,
    // })  : assert(mode != null),
  }) : super(child: child, key: key);

  @override
  bool updateShouldNotify(Appearance oldWidget) => mode != oldWidget.mode;

  static Appearance? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Appearance>();
}

mixin AppearanceState<T extends StatefulWidget> on State<T> {
  final SharedPreferences _sharedPreferences =
      SharedPreferencesManager.instance.preference;

  ThemeMode? _mode;

  void _load() {
    // getting themeMode
    String themeMode = PreferenceManager(_sharedPreferences).themeMode;
    _mode = themeModeFromString(themeMode);
  }

  void setMode(ThemeMode mode) {
    setState(() {
      _mode = mode;
    });

    // set themeMode in SharedPreferences
    PreferenceManager(_sharedPreferences).themeMode = themeModeToString(mode);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Doing this here instead of [initState] because we need to pull in an
    // InheritedWidget
    _load();
  }

  // ignore: non_constant_identifier_names
  Widget BuildWithAppearance({
    ThemeMode? initial,
    required WidgetBuilder builder,
  }) {
    return Appearance(
      mode: _mode ?? initial ?? ThemeMode.system,
      setMode: setMode,
      child: Builder(builder: builder),
    );
  }
}

//  Extensions for ThemeMode

String? themeModeToString(ThemeMode value) {
  switch (value) {
    case ThemeMode.system:
      return ThemeConstants.kThemeModeSystem;
    case ThemeMode.light:
      return ThemeConstants.kThemeModeLight;
    case ThemeMode.dark:
      return ThemeConstants.kThemeModeDark;
  }
}

ThemeMode? themeModeFromString(String value) {
  switch (value) {
    case ThemeConstants.kThemeModeSystem:
      return ThemeMode.system;
    case ThemeConstants.kThemeModeLight:
      return ThemeMode.light;
    case ThemeConstants.kThemeModeDark:
      return ThemeMode.dark;
  }
  return null;
}
