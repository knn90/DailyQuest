import 'package:daily_quest/shared/theme_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'authentication/presentation/log_in.dart';
import 'daily_quest/data/model/local_daily_quest.dart';
import 'daily_quest/data/model/local_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const dailyQuestBox = 'DailyQuest';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LocalDailyQuestAdapter());
  Hive.registerAdapter(LocalTaskAdapter());
  await Hive.openBox(dailyQuestBox);

  runApp(const ProviderScope(child: MyApp()));
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
      home: const LoginOption(),
      onGenerateTitle: (context) => AppLocalizations.of(context).dailyQuest,
    );
  }
}
