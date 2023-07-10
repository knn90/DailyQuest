import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'create_daily_quest_test.mocks.dart';

abstract class DailyQuestRepository {
  Future<DailyQuest> getLastDailyQuest();
  Future<void> saveDailyQuest({DailyQuest quest});
}

class Task {
  final String title;
  final String description;
  final bool isDone = false;

  Task({required this.title, required this.description});
}

class DailyQuest {
  final String id;
  final String timestamp;
  final List<Task> tasks;

  DailyQuest({required this.id, required this.timestamp, required this.tasks});
}

class CreateDailyQuestUseCase {
  final DailyQuestRepository repository;

  CreateDailyQuestUseCase({required this.repository});

  Future<DailyQuest> execute(
      String Function() timestamp, String Function() id) async {
    final lastQuest = await repository.getLastDailyQuest();
    final tasks = lastQuest.tasks;
    final todayQuest =
        DailyQuest(id: id(), timestamp: timestamp(), tasks: tasks);
    await repository.saveDailyQuest(quest: todayQuest);

    return todayQuest;
  }
}

@GenerateNiceMocks([MockSpec<DailyQuestRepository>()])
void main() {
  late CreateDailyQuestUseCase usecase;
  late MockDailyQuestRepository mockRepository;
  final dailyQuest = DailyQuest(id: "any id", timestamp: "1688979610", tasks: [
    Task(title: "1st title", description: "1st description"),
    Task(title: "2nd title", description: "2nd description"),
  ]);
  idProvider() => 'any id';
  timeStampProvider() => 'any timestamp';

  setUp(() {
    mockRepository = MockDailyQuestRepository();
    usecase = CreateDailyQuestUseCase(repository: mockRepository);
  });

  test("should get the current daily quest", () async {
    // arrange
    when(mockRepository.getLastDailyQuest())
        .thenAnswer((_) async => dailyQuest);
    // act
    await usecase.execute(idProvider, timeStampProvider);
    // assert
    verify(mockRepository.getLastDailyQuest());
  });

  test(
      "should create new quest with the same tasks with isDone status are false",
      () async {
    // arrange
    when(mockRepository.getLastDailyQuest())
        .thenAnswer((_) async => dailyQuest);
    // act
    final result = await usecase.execute(idProvider, timeStampProvider);
    // assert
    result.tasks.asMap().forEach((key, value) {
      expect(value.title, dailyQuest.tasks[key].title);
      expect(value.description, dailyQuest.tasks[key].description);
      expect(value.isDone, false);
    });
  });

  test('should save new quests', () async {
    // arrange
    when(mockRepository.getLastDailyQuest())
        .thenAnswer((_) async => dailyQuest);
    // act
    final result = await usecase.execute(idProvider, timeStampProvider);
    // assert
    verifyInOrder([
      mockRepository.getLastDailyQuest(),
      mockRepository.saveDailyQuest(quest: result)
    ]);
    verifyNoMoreInteractions(mockRepository);
  });
}
