import 'package:daily_quest/daily_quest/data/model/local_task.dart';

import '../model/local_daily_quest.dart';

abstract class DailyQuestLocalDataSource {
  LocalDailyQuest getLast();
  Future<void> insert({required LocalDailyQuest quest});
  Future<void> update({required LocalDailyQuest quest});
  Future<LocalDailyQuest> addTask({required LocalTask task});
  Future<LocalDailyQuest> editTask(
      {required LocalTask task, required int index});
  Future<LocalDailyQuest> toggleTask({required int index});
  Future<LocalDailyQuest> removeTask({required int index});
  Future<LocalDailyQuest> moveTask(
      {required int fromIndex, required int toIndex});
}
