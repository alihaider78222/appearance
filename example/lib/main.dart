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
      builder: (context) => MaterialApp(
        title: 'Flutter Demo',
        themeMode: Appearance.of(context)?.mode,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
        ),
        home: MyHomePage(
          title: 'Flutter Demo Home Page, ${Appearance.of(context)?.mode}',
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
            ElevatedButton(
              onPressed: () {
                if (appearance?.mode == ThemeMode.dark) {
                  appearance?.setMode(ThemeMode.light);
                } else if (appearance?.mode == ThemeMode.light) {
                  appearance?.setMode(ThemeMode.dark);
                } else {
                  appearance?.setMode(ThemeMode.light);
                }
              },
              child: const Text('Theme change'),
            ),
            Text('Theme is ${appearance?.mode}'),
          ],
        ),
      ),
    );
  }
}
