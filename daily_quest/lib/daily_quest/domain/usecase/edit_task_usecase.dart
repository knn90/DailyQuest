import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';

import '../repository/daily_quest_repository.dart';

abstract class EditTaskUseCase {
  Future<DailyQuest> editTask(Task task, int index);
}

class EditTaskUseCaseImpl implements EditTaskUseCase {
  final DailyQuestRepository repository;

  EditTaskUseCaseImpl({required this.repository});
  @override
  Future<DailyQuest> editTask(Task task, int index) {
    return repository.editTask(task: task, index: index);
  }
}
