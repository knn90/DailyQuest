import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/usecase/add_task_usecase.dart';
import 'package:daily_quest/daily_quest/domain/usecase/get_today_quest_usecase.dart';
import 'package:daily_quest/daily_quest/presentation/quest_list_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'quest_list_notifier_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetTodayQuestUseCase>(),
  MockSpec<AddTaskUseCase>(),
  MockSpec<Ref>()
])
void main() {
  late QuestListNotifier questListNotifier;
  late MockGetTodayQuestUseCase mockGetTodayQuestUseCase;
  late MockAddTaskUseCase mockAddTaskUseCase;
  late MockRef mockRef;

  setUp(() {
    mockGetTodayQuestUseCase = MockGetTodayQuestUseCase();
    mockAddTaskUseCase = MockAddTaskUseCase();
    mockRef = MockRef();
    questListNotifier = QuestListNotifier(
      ref: mockRef,
      getTodayQuestUseCase: mockGetTodayQuestUseCase,
      addTaskUseCase: mockAddTaskUseCase,
    );
  });

  group('getTodayQuest', () {
    test(
      'should return correct quest on success',
      () async {
        const quest = DailyQuest(timestamp: 'timestamp', tasks: []);
        // arrange
        when(mockGetTodayQuestUseCase.execute()).thenAnswer((_) async => quest);
        expectLater(
            questListNotifier.stream,
            emitsInOrder(const [
              AsyncLoading<DailyQuest>(),
              AsyncData<DailyQuest>(quest),
            ]));
        // act
        await questListNotifier.getTodayQuest();
        // assert
        verify(mockGetTodayQuestUseCase.execute());
        verifyNoMoreInteractions(mockGetTodayQuestUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
    test(
      'should return exception on failure',
      () async {
        // arrange
        final exception = Exception('any exception');
        when(mockGetTodayQuestUseCase.execute()).thenThrow(exception);
        expectLater(
            questListNotifier.stream,
            emitsInOrder([
              const AsyncLoading<DailyQuest>(),
              predicate<AsyncValue<DailyQuest>>((value) {
                expect(value, isA<AsyncError<DailyQuest>>());
                return true;
              }),
            ]));
        // act
        await questListNotifier.getTodayQuest();
        // assert
        verify(mockGetTodayQuestUseCase.execute());
        verifyNoMoreInteractions(mockGetTodayQuestUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });

  group('addTask', () {
    const task = Task(title: 'new title', description: 'new description');
    const quest = DailyQuest(timestamp: 'timestamp', tasks: [task]);
    test(
      'should add new task to the quest',
      () async {
        // arrange
        when(mockGetTodayQuestUseCase.execute()).thenAnswer((_) async => quest);
        when(mockAddTaskUseCase.execute(task, quest))
            .thenAnswer((_) async => quest);
        expectLater(
          questListNotifier.stream,
          emitsInOrder(const [
            AsyncLoading<DailyQuest>(),
            AsyncData(quest),
          ]),
        );
        // act
        await questListNotifier.addTask(task);
        // assert
        verify(mockAddTaskUseCase.execute(task, quest));
        verifyNoMoreInteractions(mockAddTaskUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );

    test(
      'should throw exception on add task failure',
      () async {
        // arrange
        final exception = Exception('any');
        when(mockGetTodayQuestUseCase.execute()).thenAnswer((_) async => quest);
        when(mockAddTaskUseCase.execute(task, quest)).thenThrow(exception);
        expectLater(
            questListNotifier.stream,
            emitsInOrder([
              const AsyncLoading<DailyQuest>(),
              predicate<AsyncValue<DailyQuest>>((value) {
                expect(value, isA<AsyncError<DailyQuest>>());
                return true;
              })
            ]));
        // act
        questListNotifier.addTask(task);
        // assert
        verifyNoMoreInteractions(mockAddTaskUseCase);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });
}
