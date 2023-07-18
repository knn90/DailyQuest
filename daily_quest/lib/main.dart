import 'package:daily_quest/daily_quest/presentation/quest_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'daily_quest/presentation/quest_list.dart';

const dailyQuestBox = 'DailyQuest';
void main() async {
  await Hive.initFlutter();
  await Hive.openBox(dailyQuestBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        // final box = Hive.box(dailyQuestBox);
        // final dataSource = DailyQuestLocalDataSourceImpl(box: box);
        // final repository = DailyQuestRepositoryImpl(dataSource: dataSource);
        // final getTodayQuest = GetTodayQuestUseCase(repository: repository, validator: );
        return QuestListNotifier();
      },
      child: MaterialApp(
        title: 'Daily Quest',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const DailyQuestList(),
      ),
    );
  }
}
