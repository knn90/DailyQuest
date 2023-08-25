import 'package:daily_quest/daily_quest/data/model/remote/remote_daily_quest.dart';

abstract class DailyQuestRemoteDataSource {
  Future<RemoteDailyQuest?> getTodayQuest();
  Future<void> createQuest({required RemoteDailyQuest quest});
  Future<void> updateQuest({required RemoteDailyQuest quest});
}
