import '../entity/daily_quest.dart';

abstract class DailyQuestRepository {
  Future<DailyQuest> getLastDailyQuest();
  Future<void> insertDailyQuest({required DailyQuest quest});
}
