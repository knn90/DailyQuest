import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'get_daily_quest_test.mocks.dart';

abstract class QuestValidator {
  bool validate({required DailyQuest quest});
}

class GetTodayQuestUseCase {
  final DailyQuestRepository repository;
  final QuestValidator validator;

  GetTodayQuestUseCase({
    required this.repository,
    required this.validator,
  });

  Future<DailyQuest> execute({
    required String Function() idProvider,
    required String Function() timestampProvider,
  }) async {
    final lastQuest = await repository.getLastDailyQuest();
    if (validator.validate(quest: lastQuest)) {
      return lastQuest;
    } else {
      final lastTasks = lastQuest.tasks;
      final todayQuest = await _createAndInsertNewQuest(
        idProvider,
        timestampProvider,
        lastTasks,
      );
      return todayQuest;
    }
  }

  Future<DailyQuest> _createAndInsertNewQuest(
    String Function() idProvider,
    String Function() timestampProvider,
    List<Task> lastTasks,
  ) async {
    final todayQuest = DailyQuest(
      id: idProvider(),
      timestamp: timestampProvider(),
      tasks: lastTasks
          .map((e) => Task(title: e.title, description: e.description))
          .toList(),
    );
    await repository.insertDailyQuest(quest: todayQuest);
    return todayQuest;
  }
}

@GenerateNiceMocks(
    [MockSpec<DailyQuestRepository>(), MockSpec<QuestValidator>()])
void main() {
  late GetTodayQuestUseCase useCase;
  late MockDailyQuestRepository mockRepository;
  late QuestValidator mockValidator;

  const lastQuest = DailyQuest(
    id: 'id',
    timestamp: 'timestamp',
    tasks: [
      Task(title: "1st title", description: "1st description", isDone: true),
      Task(title: "2nd title", description: "2nd description", isDone: true),
      Task(title: "3nd title", description: "3nd description", isDone: false),
    ],
  );

  const todayQuest = DailyQuest(
    id: 'today id',
    timestamp: 'today timestamp',
    tasks: [
      Task(title: "1st title", description: "1st description", isDone: false),
      Task(title: "2nd title", description: "2nd description", isDone: false),
      Task(title: "3nd title", description: "3nd description", isDone: false),
    ],
  );

  setUp(() {
    mockRepository = MockDailyQuestRepository();
    mockValidator = MockQuestValidator();
    useCase = GetTodayQuestUseCase(
        repository: mockRepository, validator: mockValidator);
  });

  test("should return the current daily quest", () async {
    // arrange
    idProvider() => 'any id';
    timeStampProvider() => 'any timestamp';
    when(mockRepository.getLastDailyQuest())
        .thenAnswer((_) async => todayQuest);
    // act
    await useCase.execute(
        idProvider: idProvider, timestampProvider: timeStampProvider);
    // assert
    verify(mockRepository.getLastDailyQuest());
  });

  group('on invalid quest', () {
    test('create new quest for the day and insert it to repository', () async {
      // arrange
      when(mockRepository.getLastDailyQuest())
          .thenAnswer((_) async => lastQuest);
      when(mockValidator.validate(quest: lastQuest)).thenReturn(false);
      // act
      final result = await useCase.execute(
        idProvider: () => todayQuest.id,
        timestampProvider: () => todayQuest.timestamp,
      );
      // assert
      expect(result, todayQuest);
      verifyInOrder([
        mockRepository.getLastDailyQuest(),
        mockValidator.validate(quest: lastQuest),
        mockRepository.insertDailyQuest(quest: todayQuest),
      ]);
      verifyNoMoreInteractions(mockRepository);
      verifyNoMoreInteractions(mockValidator);
    });
  });
  test(
      "should create new quest with the same tasks with isDone status are false",
      () async {
    // arrange
    when(mockRepository.getLastDailyQuest()).thenAnswer((_) async => lastQuest);
    when(mockValidator.validate(quest: lastQuest)).thenReturn(false);
    // act
    final result = await useCase.execute(
        idProvider: () => todayQuest.id,
        timestampProvider: () => todayQuest.timestamp);
    // assert
    result.tasks.asMap().forEach((key, value) {
      expect(value.title, todayQuest.tasks[key].title);
      expect(value.description, todayQuest.tasks[key].description);
      expect(value.isDone, false);
    });
  });

  group('on valid quest', () {
    test('should return the quest from repository', () async {
      // arrange
      idProvider() => 'any id';
      timestampProvider() => 'any timestamp';
      when(mockRepository.getLastDailyQuest())
          .thenAnswer((_) async => lastQuest);
      when(mockValidator.validate(quest: lastQuest)).thenReturn(true);
      // act
      final result = await useCase.execute(
          idProvider: idProvider, timestampProvider: timestampProvider);
      // assert
      expect(result, lastQuest);
    });
  });
}
