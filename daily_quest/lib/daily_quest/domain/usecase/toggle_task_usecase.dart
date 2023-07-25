import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';

abstract class ToggleTaskUseCase {
  Future<DailyQuest> execute(Task task, int index);
}

class ToggleTaskUseCaseImpl implements ToggleTaskUseCase {
  @override
  Future<DailyQuest> execute(Task task, int index) {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
