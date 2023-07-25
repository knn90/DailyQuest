import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';
import 'package:daily_quest/daily_quest/domain/usecase/remove_task_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remove_task_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DailyQuestRepository>()])
void main() {
  late RemoveTaskUseCase usecase;
  late MockDailyQuestRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyQuestRepository();
    usecase = RemoveTaskUseCaseImpl(repository: mockRepository);
  });

  const task = Task(title: 'Remove title', description: 'Remove description');
  const quest = DailyQuest(timestamp: '', tasks: [task]);

  test('should forward the remove task message to repository', () async {
    // arrange
    when(mockRepository.removeTask(index: 2)).thenAnswer((_) async => quest);
    // act
    final result = await usecase.excecute(2);
    // assert
    expect(result, quest);
    verify(mockRepository.removeTask(index: 2));
    verifyNoMoreInteractions(mockRepository);
  });

  test('should throw on repository removing task fails', () async {
    // arrange
    final exception = Exception('Remove task fails');
    when(mockRepository.removeTask(index: 1)).thenThrow(exception);
    // assert
    expect(() => usecase.excecute(1), throwsException);
    verify(mockRepository.removeTask(index: 1));
    verifyNoMoreInteractions(mockRepository);
  });
}
