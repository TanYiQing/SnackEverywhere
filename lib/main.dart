import 'package:flutter/material.dart';
import 'package:snackeverywhere/Screen/splashScreen.dart';
import 'package:snackeverywhere/Widget/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme
                ? CustomTheme.darktheme
                : CustomTheme.lighttheme,
            title: "SnackEverywhere",
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
