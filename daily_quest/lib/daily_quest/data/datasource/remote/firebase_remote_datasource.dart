import 'package:daily_quest/daily_quest/data/datasource/remote/daily_quest_remote_datasource.dart';
import 'package:daily_quest/daily_quest/data/model/remote/remote_daily_quest.dart';
import 'package:daily_quest/daily_quest/data/model/remote/remote_task.dart';
import 'package:firebase_database/firebase_database.dart';

final class FirebaseRemoteDataSource implements DailyQuestRemoteDataSource {
  final String _userId;
  final String _timestamp;
  final DatabaseReference _dailyQuestRef;

  FirebaseRemoteDataSource(
      {required String userId,
      required String timestamp,
      DatabaseReference? dailyQuestRef})
      : _userId = userId,
        _timestamp = timestamp,
        _dailyQuestRef =
            dailyQuestRef ?? FirebaseDatabase.instance.ref('daily_quests');
  @override
  Future<RemoteDailyQuest> addTask({required RemoteTask task}) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<RemoteDailyQuest> editTask(
      {required RemoteTask task, required int index}) {
    // TODO: implement editTask
    throw UnimplementedError();
  }

  @override
  Future<RemoteDailyQuest?> getTodayQuest() async {
    final snapshot =
        await _dailyQuestRef.child(_userId).child(_timestamp).get();
    if (snapshot.exists) {
      final map = snapshot.value as Map<String, dynamic>;
      return RemoteDailyQuest.fromJson(map);
    } else {
      return null;
    }
  }

  @override
  Future<void> insert({required RemoteDailyQuest quest}) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<RemoteDailyQuest> moveTask(
      {required int fromIndex, required int toIndex}) {
    // TODO: implement moveTask
    throw UnimplementedError();
  }

  @override
  Future<RemoteDailyQuest> removeTask({required int index}) {
    // TODO: implement removeTask
    throw UnimplementedError();
  }

  @override
  Future<RemoteDailyQuest> toggleTask({required int index}) {
    // TODO: implement toggleTask
    throw UnimplementedError();
  }

  @override
  Future<void> update({required RemoteDailyQuest quest}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
