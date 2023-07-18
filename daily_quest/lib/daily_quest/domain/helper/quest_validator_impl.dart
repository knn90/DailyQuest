import 'package:daily_quest/daily_quest/domain/helper/quest_validator.dart';

import '../entity/daily_quest.dart';

class QuestValidatorImpl implements QuestValidator {
  final String Function() timestampProvider;

  QuestValidatorImpl({required this.timestampProvider});
  @override
  bool validate({required DailyQuest quest}) {
    return timestampProvider() == quest.timestamp;
  }
}
