import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'daily_quest_list.dart';
import 'quest.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuestListNotifier(),
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
