import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appearance/appearance.dart';

class CupertinoHomePage extends StatefulWidget {
  const CupertinoHomePage({
    super.key,
  });

  @override
  State<CupertinoHomePage> createState() => _CupertinoHomePageState();
}

class _CupertinoHomePageState extends State<CupertinoHomePage>
    with AppearanceState {
  @override
  Widget build(BuildContext context) {
    return BuildWithAppearance(
      // initial => optional parameter, default value is [ThemeMode.system]
      initial: ThemeMode.dark,
      builder: (context) {
        return CupertinoApp(
          title: 'Appearance Demo',
          theme: CupertinoThemeData(
            brightness: Appearance.of(context)?.cupertinoBrightness!,
          ),
          localizationsDelegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          home: cupertinoScaffold('Appearance (Cupertino Example)'),
        );
      },
    );
  }

  Widget cupertinoScaffold(String title) {
    final appearance = Appearance.of(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton.filled(
                  onPressed: () => appearance?.setMode(ThemeMode.light),
                  // disabledColor:
                  //     appearance?.cupertinoBrightness == Brightness.dark
                  //         ? Theme.of(context).colorScheme.primary
                  //         : Colors.white,
                  child: const Icon(CupertinoIcons.sun_min),
                ),
                const SizedBox(width: 22),
                CupertinoButton.filled(
                  onPressed: () => appearance?.setMode(ThemeMode.dark),
                  // color: appearance?.cupertinoBrightness == Brightness.light
                  //     ? Theme.of(context).colorScheme.primary
                  //     : Colors.white,
                  child: const Icon(CupertinoIcons.moon),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text('Active theme is ${appearance?.mode.name}'),
            const Spacer(flex: 2),
            Align(
              alignment: Alignment.bottomCenter,
              child: CupertinoButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Show Cupertino Example'),
              ),
            ),
            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}
