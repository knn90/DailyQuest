import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'daily_quest/data/model/local_daily_quest.dart';
import 'daily_quest/data/model/local_task.dart';
import 'daily_quest/presentation/quest_list.dart';

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
      title: 'Daily Quest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DailyQuestList(),
    );
  }
}

//  ChangeNotifierProvider(
//       create: (context) {
        // final box = Hive.box(dailyQuestBox);
        // final dataSource = DailyQuestLocalDataSourceImpl(box: box);
        // final repository = DailyQuestRepositoryImpl(dataSource: dataSource);
        // final validator = QuestValidatorImpl(
        //     timestampProvider: TimestampProvider.todayTimestamp);
        // final getTodayQuest = GetTodayQuestUseCase(
        //     repository: repository,
        //     validator: validator,
        //     timestampProvider: TimestampProvider.todayTimestamp);
//         return QuestListViewModel(getTodayQuest: getTodayQuest);
//       },
//       child: ,
//     );