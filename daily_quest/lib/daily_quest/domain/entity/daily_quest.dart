import 'task.dart';

class DailyQuest {
  final String id;
  final String timestamp;
  final List<Task> tasks;

  DailyQuest({required this.id, required this.timestamp, required this.tasks});
}
