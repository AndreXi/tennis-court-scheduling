import 'package:flutter/material.dart';
import 'package:tennis_court_scheduling/l10n/l10n.dart';
import 'package:tennis_court_scheduling/router/router.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFFC6ED2C)),
        iconTheme: const IconThemeData(color: Color(0xFF006D42)),
        primaryColor: const Color(0xFF006D42),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF339966),
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: _appRouter.config(),
    );
  }
}
