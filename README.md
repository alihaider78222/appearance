![appearance](https://raw.githubusercontent.com/alihaider78222/appearance/main/screenshots/banner.png)

# Appearance

A Flutter package that easily implement Light, Dark and System theme mode in your application and persists the theme mode on restart of the application.

🚀 Demo: [Appearance](https://alihaider78222.github.io/appearance/)

## 📱 Screenshots

<p style="float: left;">
  <img src="https://raw.githubusercontent.com/alihaider78222/appearance/main/screenshots/demo_1.gif" alt="Appearance Demo 1" width="auto" height="570"  style="margin-right:20px" />

  <img src="https://raw.githubusercontent.com/alihaider78222/appearance/main/screenshots/demo_2.gif" alt="Appearance Demo 2" width="auto" height="570" />

</p>

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

## 📘 How to use

1. Initialize `SharedPreference` instance using `SharedPreferencesManager` class before `runApp()` method.


```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.instance.init();
  runApp(const MyApp());
}
```

2. extend your root class with `AppearanceState` using keyword `with`.

```dart
class _MyAppState extends State<MyApp> with AppearanceState { }
```

3. Wrap your `MaterialApp` or `CupertinoApp` with  **BuildWithAppearance**

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

- **Theme persistance**: Saved theme is persisted using [`SharedPreferences`](https://pub.dev/packages/shared_preferences) on restart.

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

Check out the **example** app in the [example](/example/lib) directory for both `Material` and `Cupertino`.

- [MaterialApp Example](/example/lib/main.dart)

- [CupertinoApp Example](/example/lib/cupertino_example.dart)

## 📝Contribution

Feel free to contribute to this [project.](https://github.com/alihaider78222/appearance)

- If you **found a bug** or **have a feature request**, open an issue.

- If you **want to contribute**, submit a [pull request.](https://github.com/alihaider78222/appearance/pulls)

## 💳 License

This project is [LICENSED](https://choosealicense.com/licenses/mit/) under the MIT License. Use it freely, but let's play nice and give credit where it's due!

## 🎉 Conclusion

I will be happy to answer any questions that you may have on this approach,</br>
If you liked this package, don't forget to show some ❤️ by smashing the ⭐.
