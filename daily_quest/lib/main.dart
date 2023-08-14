import 'package:daily_quest/authentication/presentation/reset_password.dart';
import 'package:daily_quest/daily_quest/presentation/today_quest/today_quest.dart';
import 'package:daily_quest/shared/theme_constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'authentication/presentation/sign_in.dart';
import 'daily_quest/data/model/local_daily_quest.dart';
import 'daily_quest/data/model/local_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'firebase_options.dart';

const dailyQuestBox = 'DailyQuest';

void main() async {
  await _initHive();
  await _initFirebase();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LocalDailyQuestAdapter());
  Hive.registerAdapter(LocalTaskAdapter());
  await Hive.openBox(dailyQuestBox);
}

Future<void> _initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const AppCoordinator(),
      onGenerateTitle: (context) => AppLocalizations.of(context).dailyQuest,
    );
  }
}

class AppCoordinator extends StatelessWidget {
  const AppCoordinator({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Scaffold(
      body: SafeArea(
          child: SignInScreen(
        onLoginSucceed: () {
          navigator.pushReplacement(MaterialPageRoute(
              builder: (context) => const TodayQuestScreen()));
        },
        onResetPasswordPressed: () {
          navigator.push(MaterialPageRoute(
              builder: (context) => const ResetPasswordScreen()));
        },
      )),
    );
  }
}
