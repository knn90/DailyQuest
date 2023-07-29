import '../entity/daily_quest.dart';

abstract class MoveTaskUseCase {
  Future<DailyQuest> execute(int fromIndex, int toIndex);
}

class MoveTaskUseCaseImpl implements MoveTaskUseCase {
  @override
  Future<DailyQuest> execute(int fromIndex, int toIndex) {
    // TODO: implement moveTask
    throw UnimplementedError();
  }
}
