import 'package:daily_quest/daily_quest/data/model/remote/remote_daily_quest.dart';
import 'package:daily_quest/daily_quest/data/model/remote/remote_task.dart';

abstract class DailyQuestRemoteDataSource {
  Future<RemoteDailyQuest?> getTodayQuest();
  Future<void> insert({required RemoteDailyQuest quest});
  Future<void> update({required RemoteDailyQuest quest});
  Future<RemoteDailyQuest> addTask({required RemoteTask task});
  Future<RemoteDailyQuest> editTask(
      {required RemoteTask task, required int index});
  Future<RemoteDailyQuest> toggleTask({required int index});
  Future<RemoteDailyQuest> removeTask({required int index});
  Future<RemoteDailyQuest> moveTask(
      {required int fromIndex, required int toIndex});
}
