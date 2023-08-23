import 'package:daily_quest/daily_quest/data/model/remote/remote_task.dart';

class RemoteDailyQuest {
  final String timestamp;
  final List<RemoteTask> tasks;

  const RemoteDailyQuest({
    required this.timestamp,
    required this.tasks,
  });
}
