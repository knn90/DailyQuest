import '../model/local_daily_quest.dart';

abstract class DailyQuestLocalDataSource {
  LocalDailyQuest getLast();
  Future<void> insert({required LocalDailyQuest quest});
  Future<void> update({required LocalDailyQuest quest});
}
