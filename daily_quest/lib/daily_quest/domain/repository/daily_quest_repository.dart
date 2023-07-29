import 'package:daily_quest/daily_quest/domain/entity/task.dart';

import '../entity/daily_quest.dart';

abstract class DailyQuestRepository {
  Future<DailyQuest> getLastDailyQuest();
  Future<void> insertDailyQuest({required DailyQuest quest});
  Future<void> updateQuest({required DailyQuest quest});
  Future<DailyQuest> addTask({required Task task});
  Future<DailyQuest> editTask({required Task task, required int index});
  Future<DailyQuest> toggleTask({required int index});
  Future<DailyQuest> removeTask({required int index});
  Future<DailyQuest> moveTask({required int fromIndex, required int toIndex});
}
