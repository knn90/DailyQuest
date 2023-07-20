import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';

import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';

import 'add_task_usecase.dart';

class AddTaskUseCaseImpl implements AddTaskUseCase {
  final DailyQuestRepository repository;

  AddTaskUseCaseImpl({required this.repository});

  @override
  Future<DailyQuest> execute(Task task) {
    repository.addTask(task: task);
  }
}
