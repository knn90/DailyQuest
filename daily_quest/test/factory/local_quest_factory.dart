import 'package:daily_quest/daily_quest/data/model/local/local_daily_quest.dart';
import 'package:daily_quest/daily_quest/data/model/local/local_task.dart';

final class LocalQuestFactory {
  LocalQuestFactory._();

  static LocalDailyQuest make({
    String timestamp = 'any timestamp',
    List<LocalTask> tasks = const [],
  }) {
    return LocalDailyQuest(timestamp: timestamp, tasks: tasks);
  }
}
