import 'package:daily_quest/daily_quest/data/model/local_task.dart';

import '../model/local_daily_quest.dart';

abstract class DailyQuestLocalDataSource {
  LocalDailyQuest getLast();
  Future<void> insert({required LocalDailyQuest quest});
  Future<void> update({required LocalDailyQuest quest});
  Future<void> addTask({required LocalTask task});
}
