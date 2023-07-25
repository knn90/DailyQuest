import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';

abstract class EditTaskUseCase {
  Future<DailyQuest> editTask(Task task, int index);
}
