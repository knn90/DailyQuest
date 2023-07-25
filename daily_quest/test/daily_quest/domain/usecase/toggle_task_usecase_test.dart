import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';
import 'package:daily_quest/daily_quest/domain/usecase/toggle_task_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'edit_task_usecase_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DailyQuestRepository>()])
void main() {
  late ToggleTaskUseCase usecase;
  late MockDailyQuestRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyQuestRepository();
    usecase = ToggleTaskUseCaseImpl(repository: mockRepository);
  });

  const quest = DailyQuest(timestamp: '', tasks: []);

  test('should throw on toggle task fails', () async {
    // arrange
    final exception = Exception('Toggle task fails');
    when(mockRepository.toggleTask(index: 0)).thenThrow(exception);
    // assert
    expect(() => usecase.execute(0), throwsException);
  });

  test('should forward toggle task message to repository', () async {
    // arrange
    when(mockRepository.toggleTask(index: 1)).thenAnswer((_) async => quest);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, quest);
    verify(mockRepository.toggleTask(index: 1));
    verifyNoMoreInteractions(mockRepository);
  });
}
