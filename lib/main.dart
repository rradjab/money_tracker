import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:money_tracker/generated/l10n.dart';
import 'package:money_tracker/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_tracker/providers/providers.dart';
import 'package:money_tracker/screens/auth_screen.dart';
import 'package:money_tracker/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting();

  runApp(ProviderScope(overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  ], child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale(ref.watch(localeProvider)),
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: ref.watch(authStreamProvider).when(
            data: (User? user) {
              final List<BottomNavigationBarItem> items = [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.credit_card),
                  label: S.current.homeSpends,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.monetization_on),
                  label: S.current.homeProfits,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.place_outlined),
                  label: S.current.homePlans,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person),
                  label: S.current.homeProfile,
                ),
              ];

              return user != null
                  ? HomeScreen(
                      items: items,
                    )
                  : const AuthScreen();
            },
            error: (error, stackTrace) => const CircularProgressIndicator(),
            loading: () =>
                const Scaffold(body: Center(child: LinearProgressIndicator())),
          ),
    );
  }
}
