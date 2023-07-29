import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';

import '../entity/daily_quest.dart';

abstract class MoveTaskUseCase {
  Future<DailyQuest> execute(int fromIndex, int toIndex);
}

class MoveTaskUseCaseImpl implements MoveTaskUseCase {
  final DailyQuestRepository repository;

  MoveTaskUseCaseImpl({required this.repository});
  @override
  Future<DailyQuest> execute(int fromIndex, int toIndex) {
    return repository.moveTask(fromIndex: fromIndex, toIndex: toIndex);
  }
}
