import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';
import 'package:daily_quest/daily_quest/domain/usecase/add_task_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_daily_quest_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DailyQuestRepository>()])
void main() {
  late AddTaskUseCaseImpl useCase;
  late MockDailyQuestRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyQuestRepository();
    useCase = AddTaskUseCaseImpl(repository: mockRepository);
  });

  const insertingTask = Task(title: 'title', description: 'description');
  const quest = DailyQuest(timestamp: 'timestamp', tasks: []);
  const updatedQuest =
      DailyQuest(timestamp: 'timestamp', tasks: [insertingTask]);
  test('should add task to the today quest', () async {
    // arrange
    when(mockRepository.getLastDailyQuest()).thenAnswer((_) async => quest);
    when(mockRepository.updateQuest(quest: quest)).thenAnswer((_) async => ());
    // act
    final result = await useCase.execute(insertingTask);
    // assert
    expect(result, updatedQuest);
    verify(mockRepository.getLastDailyQuest());
    verify(mockRepository.updateQuest(quest: result));
    verifyNoMoreInteractions(mockRepository);
  });

  group('should throw', () {
    test('when repository getLastDailyQuest fails', () async {
      // arrange
      final exception = Exception('Get last daily quest fails');
      when(mockRepository.getLastDailyQuest()).thenThrow(exception);
      when(mockRepository.updateQuest(quest: quest))
          .thenAnswer((_) async => ());
      // assert
      expect(() => useCase.execute(insertingTask), throwsA(isA<Exception>()));
    });

    test('when repository updateQuest fails', () async {
      // arrange
      final exception = Exception('Update Quest fails');
      when(mockRepository.getLastDailyQuest()).thenAnswer((_) async => quest);
      when(mockRepository.updateQuest(quest: updatedQuest))
          .thenThrow(exception);
      // assert
      expect(() => useCase.execute(insertingTask), throwsA(isA<Exception>()));
    });
  });
}
