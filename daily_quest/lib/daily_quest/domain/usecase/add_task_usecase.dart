import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';

import '../entity/task.dart';
import '../repository/daily_quest_repository.dart';

abstract class AddTaskUseCase {
  Future<DailyQuest> execute(Task task);
}

class AddTaskUseCaseImpl implements AddTaskUseCase {
  final DailyQuestRepository repository;

  AddTaskUseCaseImpl({required this.repository});

  @override
  Future<DailyQuest> execute(Task task) async {
    final quest = await repository.addTask(task: task);
    return quest;
  }
}
