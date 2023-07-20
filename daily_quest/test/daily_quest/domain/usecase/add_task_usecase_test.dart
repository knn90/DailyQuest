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

  test('should add task to the today quest', () async {
    // arrange
    final task = Task(title: 'title', description: 'description');
    when(mockRepository.addTask(task: task)).thenAnswer((_) async => ());
    // act
    useCase.execute(task);
    // assert
    verify(mockRepository.addTask(task: task));
    verifyNoMoreInteractions(mockRepository);
  });
}
