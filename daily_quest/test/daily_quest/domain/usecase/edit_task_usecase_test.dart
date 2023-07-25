import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';
import 'package:daily_quest/daily_quest/domain/usecase/edit_task_usecase.dart';
import 'package:daily_quest/daily_quest/domain/usecase/edit_task_usecase_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_task_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DailyQuestRepository>()])
void main() {
  late EditTaskUseCase useCase;
  late MockDailyQuestRepository mockDailyQuestRepository;

  setUp(() {
    mockDailyQuestRepository = MockDailyQuestRepository();
    useCase = EditTaskUseCaseImpl(repository: mockDailyQuestRepository);
  });

  const task = Task(title: 'Edit title', description: 'Edit description');
  const quest = DailyQuest(timestamp: '', tasks: [task]);
  test('should forward edit task message to repository', () async {
    // arrange
    when(mockDailyQuestRepository.editTask(task: task, index: 1))
        .thenAnswer((_) async => quest);
    // act
    final result = await useCase.editTask(task, 1);
    // assert
    expect(result, quest);
    verify(mockDailyQuestRepository.editTask(task: task, index: 1));
    verifyNoMoreInteractions(mockDailyQuestRepository);
  });

  test('should throw on repository edit task fails', () async {
    // arrange
    final exception = Exception('Edit task fails');
    when(mockDailyQuestRepository.editTask(task: task, index: 0))
        .thenThrow(exception);
    // assert
    expect(() => useCase.editTask(task, 0), throwsA(isA<Exception>()));
    verify(mockDailyQuestRepository.editTask(task: task, index: 0));
    verifyNoMoreInteractions(mockDailyQuestRepository);
  });
}
