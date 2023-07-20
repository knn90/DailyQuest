import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';

import '../entity/task.dart';

abstract class AddTaskUseCase {
  Future<DailyQuest> execute(Task task);
}
