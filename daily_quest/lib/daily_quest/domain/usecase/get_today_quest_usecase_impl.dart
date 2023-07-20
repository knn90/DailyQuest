import '../entity/daily_quest.dart';
import '../entity/task.dart';
import '../exception/exceptions.dart';
import '../helper/quest_validator.dart';
import '../repository/daily_quest_repository.dart';
import 'get_today_quest_usecase.dart';

class GetTodayQuestUseCaseImpl implements GetTodayQuestUseCase {
  final DailyQuestRepository repository;
  final QuestValidator validator;
  String Function() timestampProvider;
  GetTodayQuestUseCaseImpl({
    required this.repository,
    required this.validator,
    required this.timestampProvider,
  });

  @override
  Future<DailyQuest> execute() async {
    try {
      final lastQuest = await repository.getLastDailyQuest();
      if (validator.validate(quest: lastQuest)) {
        return lastQuest;
      } else {
        return await _createAndInsertNewQuest(
          timestampProvider,
          lastQuest.tasks,
        );
      }
    } on DailyQuestNotFound catch (_) {
      return await _createAndInsertNewQuest(timestampProvider, []);
    }
  }

  Future<DailyQuest> _createAndInsertNewQuest(
    String Function() timestampProvider,
    List<Task> lastTasks,
  ) async {
    final todayQuest = DailyQuest(
      timestamp: timestampProvider(),
      tasks: lastTasks
          .map((e) => Task(title: e.title, description: e.description))
          .toList(),
    );
    await repository.insertDailyQuest(quest: todayQuest);
    return todayQuest;
  }
}
