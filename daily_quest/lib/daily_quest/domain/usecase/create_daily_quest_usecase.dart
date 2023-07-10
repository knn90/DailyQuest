import '../entity/daily_quest.dart';
import '../repository/daily_quest_repository.dart';

class CreateDailyQuestUseCase {
  final DailyQuestRepository repository;

  CreateDailyQuestUseCase({required this.repository});

  Future<DailyQuest> execute(
      String Function() timestamp, String Function() id) async {
    final lastQuest = await repository.getLastDailyQuest();
    final tasks = lastQuest.tasks;
    final todayQuest =
        DailyQuest(id: id(), timestamp: timestamp(), tasks: tasks);
    await repository.saveDailyQuest(quest: todayQuest);

    return todayQuest;
  }
}
