import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:monitoring_demo/home/home.dart';
import 'package:monitoring_demo/l10n/l10n.dart';
import 'package:monitoring_demo/login/login.dart';
import 'package:monitoring_demo/shopping/shopping.dart';

final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: LoginPage.routeName,
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: _analytics),
      ],
      routes: {
        LoginPage.routeName: (_) => const LoginPage(),
        HomePage.routeName: (_) => const HomePage(),
        ShoppingPage.routeName: (_) => const ShoppingPage(),
      },
    );
  }
}
