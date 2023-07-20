import '../entity/daily_quest.dart';

abstract class GetTodayQuestUseCase {
  Future<DailyQuest> execute();
}
