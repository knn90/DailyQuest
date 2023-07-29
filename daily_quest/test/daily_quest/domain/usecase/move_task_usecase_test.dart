import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';
import 'package:daily_quest/daily_quest/domain/usecase/move_task_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'move_task_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DailyQuestRepository>()])
void main() {
  late MoveTaskUseCase useCase;
  late MockDailyQuestRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyQuestRepository();
    useCase = MoveTaskUseCaseImpl(repository: mockRepository);
  });

  const movingTask = Task(title: 'title', description: 'description');
  const updatedQuest = DailyQuest(timestamp: 'timestamp', tasks: [movingTask]);

  test('should forward moving task message to repository', () async {
    // arrange
    when(mockRepository.moveTask(fromIndex: 1, toIndex: 2))
        .thenAnswer((_) async => updatedQuest);
    // act
    final result = await useCase.execute(1, 2);
    // assert
    expect(result, updatedQuest);
    verify(mockRepository.moveTask(fromIndex: 1, toIndex: 2));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should throw when repository updateQuest fails', () async {
    // arrange
    final exception = Exception('Move task fails');
    when(mockRepository.moveTask(fromIndex: 2, toIndex: 5))
        .thenThrow(exception);
    // assert
    expect(
      () => useCase.execute(2, 5),
      throwsA(isA<Exception>()),
    );
    verify(mockRepository.moveTask(fromIndex: 2, toIndex: 5));
    verifyNoMoreInteractions(mockRepository);
  });
}
