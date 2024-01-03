![appearance](https://raw.githubusercontent.com/alihaider78222/appearance/main/screenshots/banner.png)

# Appearance

A Flutter package that easily implement Light, Dark and System theme mode in your application and persists the theme mode on restart of the application.

🚀 Demo: [Appearance](https://alihaider78222.github.io/appearance/)

## 📱 Screenshots

<div style="text-align: center">
  <video src="https://raw.githubusercontent.com/alihaider78222/appearance/main/screenshots/demo_1.mp4" alt="Appearance Demo 1" width="auto" height="570">
  </video>
  <video src="https://raw.githubusercontent.com/alihaider78222/appearance/main/screenshots/demo_2.mp4" alt="Appearance Demo 2" width="auto" height="570">
  </video>

</div>

## 🛠 Installation

1. Add dependency to `pubspec.yaml` file:</br>
Get the latest version from the 'Installing' tab on [pub.dev](https://pub.dev/packages/appearance/install)

```yaml
dependencies:
  appearance: ^latest_version
```

2. Import the package

```dart
import 'package:appearance/appearance.dart';
```

3. Initialize `SharedPreference` instance using `SharedPreferencesManager` class before `runApp()` method.


```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.instance.init();
  runApp(const MyApp());
}
```

4. extend your root class with `AppearanceState` using keyword `with`.

```dart
class _MyAppState extends State<MyApp> with AppearanceState { }
```

5. Wrap your `MaterialApp` or `CupertinoApp` with  **BuildWithAppearance**

```dart
BuildWithAppearance(
    initial: ThemeMode.light, // optional : default value is [ThemeMode.system]
    builder: (context) => MaterialApp()
);
```

### Using `MaterialApp`

```dart
BuildWithAppearance(
    initial: ThemeMode.light, // optional : default value is [ThemeMode.system]
    builder: (context) => MaterialApp(
        title: 'Appearance (Material Example)',
        themeMode: Appearance.of(context)?.mode,
        theme: ThemeData(
            brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
        ),
        home: const HomeMaterialPage(),
    ),
);
```

### Using `CupertinoApp`

```dart
BuildWithAppearance(
    initial: ThemeMode.light, // optional : default value is [ThemeMode.system]
    builder: (context) {
        return CupertinoApp(
            title: 'Appearance (Cupertino Example)',
            theme: CupertinoThemeData(
                brightness: Appearance.of(context)?.cupertinoBrightness!,
            ),
            localizationsDelegates: const [
                DefaultMaterialLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
            ],
            home: HomeCupertinoPage(),
        );
    },
);
```

## 🌟 Features

- **Light, Dark and System** mode options to change theme of app.

- **Theme persistance**: Saved theme is persisted using `SharedPreferences` on restart.

- **Auto Listen Theme Mode changes**, without adding extra listener.

- **Material and Cupertino**, both apps are supported.

## 🧰 Parameters

- <b>initial</b>: *[optional]* </br>Set the initial `ThemeMode` of the app, by default its value is `ThemeMode.system`

## Change Theme Mode

You can use the `setMode` method to change the theme mode of the app.

```
 // sets theme mode to System
 Appearance.of(context)?.setMode(ThemeMode.system),

 // sets theme mode to Light
 Appearance.of(context)?.setMode(ThemeMode.light),

 // sets theme mode to Dark
 Appearance.of(context)?.setMode(ThemeMode.dark),
```

## Get Theme Mode

```
 // get active theme mode
 Appearance.of(context)?.mode
```


## 💻 Example

Check out the **example** app in the [example](example) directory for both `Material` an `Cupertino`.

```dart

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  //
  // Initiate shared preference instance with [SharedPreferencesManager].
  //
  await SharedPreferencesManager.instance.init();

  // OR : ---------------------------------------------------------------------
  //
  // If you are using getIt and SharedPreferences instance is already initiated
  // then we can pass that SharedPreferences instance from getIt to SharedPreferencesManager
  // to avoid creating multiple instance, e.g
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
      // initial: ThemeMode.light, optional parameter, default value is [ThemeMode.system]
      builder: (context) => MaterialApp(
        title: 'Appearance Demo',
        themeMode: Appearance.of(context)?.mode,
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
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
```

## 📝Contribution

Of course the project is open source, and you are welcome to contribute. [repository link](https://github.com/alihaider78222/appearance)

- If you **found a bug**, open an issue.

- If you **have a feature request**, open an issue.

- If you **want to contribute**, submit a pull request.

## 💳 License

This project is [LICENSED](https://choosealicense.com/licenses/mit/) under the MIT License. Use it freely, but let's play nice and give credit where it's due!

## 🎉 Conclusion

I will be happy to answer any questions that you may have on this approach,</br>
If you liked this package, don't forget to show some ❤️ by smashing the ⭐.
