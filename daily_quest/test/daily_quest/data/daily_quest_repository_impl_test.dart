import 'package:daily_quest/daily_quest/data/datasource/daily_quest_local_datasource.dart';
import 'package:daily_quest/daily_quest/data/model/local_daily_quest.dart';
import 'package:daily_quest/daily_quest/data/model/local_task.dart';
import 'package:daily_quest/daily_quest/data/repository/daily_quest_repository_impl.dart';
import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/exception/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'daily_quest_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DailyQuestLocalDataSource>()])
void main() {
  late DailyQuestRepositoryImpl repository;
  late MockDailyQuestLocalDataSource mockDataSource;
  const LocalDailyQuest localQuest =
      LocalDailyQuest(id: 'any id', timestamp: 'any timestamp', tasks: [
    LocalTask(title: "task1", description: "description1"),
    LocalTask(title: "task2", description: "description2"),
    LocalTask(title: "task3", description: "description3"),
  ]);
  final DailyQuest dailyQuest = localQuest.toEntity();

  setUp(() {
    mockDataSource = MockDailyQuestLocalDataSource();
    repository = DailyQuestRepositoryImpl(dataSource: mockDataSource);
  });

  group('get last daily quest', () {
    group('on empty data source', () {
      test('should throw daily quest not found error', () async {
        // arrange
        when(mockDataSource.getLast()).thenThrow(DailyQuestNotFound());
        // assert
        expect(() => repository.getLastDailyQuest(),
            throwsA(isA<DailyQuestNotFound>()));
        verify(mockDataSource.getLast());
        verifyNoMoreInteractions(mockDataSource);
      });
    });

    group('on non-empty data source', () {
      test('should return daily quest with correct data', () async {
        // arrange
        when(mockDataSource.getLast()).thenAnswer((_) async => localQuest);
        // act
        final result = await repository.getLastDailyQuest();
        // assert
        expect(result, dailyQuest);
        verify(mockDataSource.getLast());
        verifyNoMoreInteractions(mockDataSource);
      });
    });
  });

  group('insert daily daily quest', () {
    test('should insert new quest', () async {
      // arrange
      when(mockDataSource.save(quest: localQuest)).thenAnswer((_) async => ());
      // act
      await repository.insertDailyQuest(quest: dailyQuest);
      // assert
      verify(mockDataSource.save(quest: localQuest));
    });
  });
}
