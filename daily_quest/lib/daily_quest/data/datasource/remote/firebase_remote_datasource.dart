import 'package:daily_quest/daily_quest/data/datasource/remote/daily_quest_remote_datasource.dart';
import 'package:daily_quest/daily_quest/data/model/remote/remote_daily_quest.dart';
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
  Future<void> createQuest({required RemoteDailyQuest quest}) async {
    await _dailyQuestRef.child(_userId).child(_timestamp).set(quest.toJson());
  }

  @override
  Future<void> updateQuest({required RemoteDailyQuest quest}) async {
    await _dailyQuestRef
        .child(_userId)
        .child(_timestamp)
        .update(quest.toJson());
  }
}
