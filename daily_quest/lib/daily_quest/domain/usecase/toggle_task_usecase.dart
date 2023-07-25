import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';

abstract class ToggleTaskUseCase {
  Future<DailyQuest> execute(Task task, int index);
}

class ToggleTaskUseCaseImpl implements ToggleTaskUseCase {
  final DailyQuestRepository repository;

  ToggleTaskUseCaseImpl({required this.repository});
  @override
  Future<DailyQuest> execute(Task task, int index) {
    return repository.toggleTask(task: task, index: index);
  }
}
