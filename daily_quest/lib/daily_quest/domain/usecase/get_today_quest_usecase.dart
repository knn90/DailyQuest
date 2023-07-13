import '../../data/datasource/daily_quest_local_datasource.dart';
import '../entity/daily_quest.dart';
import '../entity/task.dart';
import '../helper/quest_validator.dart';
import '../repository/daily_quest_repository.dart';

class GetTodayQuestUseCase {
  final DailyQuestRepository repository;
  final QuestValidator validator;

  GetTodayQuestUseCase({
    required this.repository,
    required this.validator,
  });

  Future<DailyQuest> execute({
    required String Function() idProvider,
    required String Function() timestampProvider,
  }) async {
    try {
      final lastQuest = await repository.getLastDailyQuest();
      if (validator.validate(quest: lastQuest)) {
        return lastQuest;
      } else {
        return await _createAndInsertNewQuest(
          idProvider,
          timestampProvider,
          lastQuest.tasks,
        );
      }
    } on DailyQuestNotFound catch (_) {
      return await _createAndInsertNewQuest(idProvider, timestampProvider, []);
    }
  }

  Future<DailyQuest> _createAndInsertNewQuest(
    String Function() idProvider,
    String Function() timestampProvider,
    List<Task> lastTasks,
  ) async {
    final todayQuest = DailyQuest(
      id: idProvider(),
      timestamp: timestampProvider(),
      tasks: lastTasks
          .map((e) => Task(title: e.title, description: e.description))
          .toList(),
    );
    await repository.insertDailyQuest(quest: todayQuest);
    return todayQuest;
  }
}
