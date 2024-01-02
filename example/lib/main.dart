import 'package:flutter/material.dart';
import 'package:appearance/appearance.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  // Initiate shared preference instance
  //
  await SharedPreferencesManager.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AppearanceState {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BuildWithAppearance(
      initial: ThemeMode.dark,
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
        home: const MyHomePage(
          title: 'Appearance Demo',
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                themeCard(
                  mode: ThemeMode.system,
                  icon: Icons.contrast_rounded,
                  onTap: () => appearance?.setMode(ThemeMode.system),
                ),
                const SizedBox(width: 22),
                themeCard(
                  mode: ThemeMode.light,
                  icon: Icons.wb_sunny_outlined,
                  onTap: () => appearance?.setMode(ThemeMode.light),
                ),
                const SizedBox(width: 22),
                themeCard(
                  mode: ThemeMode.dark,
                  icon: Icons.nights_stay_outlined,
                  onTap: () => appearance?.setMode(ThemeMode.dark),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text('Active theme is ${appearance?.mode.name}'),
          ],
        ),
      ),
    );
  }

  themeCard({required ThemeMode mode, required IconData icon, required onTap}) {
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
}
