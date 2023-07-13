import '../entity/daily_quest.dart';

abstract class QuestValidator {
  bool validate({required DailyQuest quest});
}
