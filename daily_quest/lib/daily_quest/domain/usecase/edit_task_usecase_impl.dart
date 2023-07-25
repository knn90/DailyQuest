import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';

import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';

import 'edit_task_usecase.dart';

class EditTaskUseCaseImpl implements EditTaskUseCase {
  final DailyQuestRepository repository;

  EditTaskUseCaseImpl({required this.repository});
  @override
  Future<DailyQuest> editTask(Task task, int index) {
    return repository.editTask(task: task, index: index);
  }
}
