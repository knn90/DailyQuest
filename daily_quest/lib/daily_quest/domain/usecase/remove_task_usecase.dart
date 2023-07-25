import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';

abstract class RemoveTaskUseCase {
  Future<DailyQuest> excecute(int index);
}

class RemoveTaskUseCaseImpl implements RemoveTaskUseCase {
  final DailyQuestRepository repository;

  RemoveTaskUseCaseImpl({required this.repository});

  @override
  Future<DailyQuest> excecute(int index) {
    return repository.removeTask(index: index);
  }
}
