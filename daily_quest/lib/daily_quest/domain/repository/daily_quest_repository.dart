import '../entity/daily_quest.dart';
import '../entity/task.dart';

abstract class DailyQuestRepository {
  Future<DailyQuest> getLastDailyQuest();
  Future<void> insertDailyQuest({required DailyQuest quest});
  Future<void> addTask({required Task task});
}
