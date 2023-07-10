import '../entity/daily_quest.dart';

abstract class DailyQuestRepository {
  Future<DailyQuest> getLastDailyQuest();
  Future<void> saveDailyQuest({DailyQuest quest});
}
