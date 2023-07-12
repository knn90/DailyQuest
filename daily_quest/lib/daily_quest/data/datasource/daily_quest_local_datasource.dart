import '../model/local_daily_quest.dart';

abstract class DailyQuestLocalDataSource {
  Future<LocalDailyQuest> getLast();
  Future<void> save({required LocalDailyQuest quest});
}

class DailyQuestNotFound implements Exception {}
