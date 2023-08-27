import 'package:daily_quest/daily_quest/data/model/local/local_task.dart';

final class LocalTaskFactory {
  LocalTaskFactory._();
  static LocalTask make({
    String title = 'any title',
    String description = 'any description',
    bool isDone = false,
  }) {
    return LocalTask(title: title, description: description, isDone: isDone);
  }
}
