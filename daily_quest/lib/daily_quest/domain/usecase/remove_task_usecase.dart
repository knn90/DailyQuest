import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';

abstract class RemoveTaskUseCase {
  Future<DailyQuest> excecute(int index);
}

class RemoveTaskUseCaseImpl implements RemoveTaskUseCase {
  @override
  Future<DailyQuest> excecute(int index) {
    // TODO: implement excecute
    throw UnimplementedError();
  }
}
