import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/helper/quest_validator_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late QuestValidatorImpl questValidator;
  timestampProvider() => 'todayTimestamp';

  setUp(() {
    questValidator = QuestValidatorImpl(timestampProvider: timestampProvider);
  });

  test('return false when the timestamp is different with today timestamp', () {
    const invalidQuest =
        DailyQuest(id: 'id', timestamp: 'any timestamp', tasks: []);
    // act
    final result = questValidator.validate(quest: invalidQuest);
    // assert
    expect(result, false);
  });

  test('should return true when timestamp is match with today timestamp', () {
    // arrange
    const validQuest =
        DailyQuest(id: 'today id', timestamp: 'todayTimestamp', tasks: []);
    // act
    final result = questValidator.validate(quest: validQuest);
    // assert
    expect(result, true);
  });
}
