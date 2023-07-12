import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';
import 'package:daily_quest/daily_quest/domain/usecase/create_daily_quest_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'create_daily_quest_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DailyQuestRepository>()])
void main() {
  late CreateDailyQuestUseCase usecase;
  late MockDailyQuestRepository mockRepository;
  const dailyQuest = DailyQuest(id: "any id", timestamp: "1688979610", tasks: [
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
      mockRepository.insertDailyQuest(quest: result)
    ]);
    verifyNoMoreInteractions(mockRepository);
  });
}
