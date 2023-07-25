import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';

abstract class ToggleTaskUseCase {
  Future<DailyQuest> execute(int index);
}

class ToggleTaskUseCaseImpl implements ToggleTaskUseCase {
  final DailyQuestRepository repository;

  ToggleTaskUseCaseImpl({required this.repository});
  @override
  Future<DailyQuest> execute(int index) {
    return repository.toggleTask(index: index);
  }
}
