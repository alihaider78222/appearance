import 'package:flutter/material.dart';
import 'package:appearance/appearance.dart';

import 'cupertino_example.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  // Initiate shared preference instance
  //
  await SharedPreferencesManager.instance.init();

  // OR
  // If you are using getIt and SharedPreferences instance is already initiated
  // then we can pass that SharedPreferences instance from getIt to SharedPreferencesManager
  // e.g
  //
  // await SharedPreferencesManager.instance.init( getIt<SharedPreferences> );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AppearanceState {
  @override
  Widget build(BuildContext context) {
    //
    // Wrap your root Material/Cupertino widget with [BuildWithAppearance].
    //
    return BuildWithAppearance(
      // initial => optional parameter, default value is [ThemeMode.system]
      // initial: ThemeMode.dark,
      builder: (context) => MaterialApp(
        title: 'Appearance Demo',
        themeMode: Appearance.of(context)?.mode,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        home: const MaterialHomePage(
          title: 'Appearance (Material Example)',
        ),
      ),
    );
  }
}

class MaterialHomePage extends StatefulWidget {
  const MaterialHomePage({super.key, required this.title});

  final String title;

  @override
  State<MaterialHomePage> createState() => _MaterialHomePageState();
}

class _MaterialHomePageState extends State<MaterialHomePage> {
  @override
  Widget build(BuildContext context) {
    final appearance = Appearance.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                themeCard(
                  context,
                  mode: ThemeMode.system,
                  icon: Icons.contrast_rounded,
                  onTap: () => appearance?.setMode(ThemeMode.system),
                ),
                const SizedBox(width: 22),
                themeCard(
                  context,
                  mode: ThemeMode.light,
                  icon: Icons.wb_sunny_outlined,
                  onTap: () => appearance?.setMode(ThemeMode.light),
                ),
                const SizedBox(width: 22),
                themeCard(
                  context,
                  mode: ThemeMode.dark,
                  icon: Icons.nights_stay_outlined,
                  onTap: () => appearance?.setMode(ThemeMode.dark),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text('Active theme is ${appearance?.mode.name}'),
            const Spacer(flex: 2),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: _navigateToCupertinoExample,
                child: const Text('Show Cupertino Example'),
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }

  themeCard(BuildContext context,
      {required ThemeMode mode, required IconData icon, required onTap}) {
    var activeThemeMode = Appearance.of(context)?.mode;
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.shadow,
      color: activeThemeMode == mode
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).backgroundColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 22),
          child: Icon(
            icon,
            size: 32,
            color: activeThemeMode != mode
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
          ),
        ),
      ),
    );
  }

  _navigateToCupertinoExample() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CupertinoHomePage()),
    );
  }
}
