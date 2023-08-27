import 'package:daily_quest/daily_quest/data/model/remote/remote_daily_quest.dart';
import 'package:daily_quest/daily_quest/data/model/remote/remote_task.dart';

final class RemoteDailyQuestFactory {
  RemoteDailyQuestFactory._();

  static RemoteDailyQuest make({
    String timestamp = 'any time stamp',
    List<RemoteTask> tasks = const [],
  }) {
    return RemoteDailyQuest(timestamp: timestamp, tasks: tasks);
  }
}
