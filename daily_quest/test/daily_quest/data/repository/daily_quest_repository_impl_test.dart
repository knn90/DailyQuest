import 'package:daily_quest/daily_quest/data/datasource/daily_quest_local_datasource.dart';
import 'package:daily_quest/daily_quest/data/model/local_daily_quest.dart';
import 'package:daily_quest/daily_quest/data/model/local_task.dart';
import 'package:daily_quest/daily_quest/data/repository/daily_quest_repository_impl.dart';
import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/exception/exceptions.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'daily_quest_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DailyQuestLocalDataSource>()])
void main() {
  late DailyQuestRepository repository;
  late MockDailyQuestLocalDataSource mockDataSource;
  const LocalDailyQuest localQuest =
      LocalDailyQuest(timestamp: 'any timestamp', tasks: [
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
        when(mockDataSource.getLast()).thenReturn(localQuest);
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
      when(mockDataSource.insert(quest: localQuest))
          .thenAnswer((_) async => ());
      // act
      await repository.insertDailyQuest(quest: dailyQuest);
      // assert
      verify(mockDataSource.insert(quest: localQuest));
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('update daily quest', () {
    test('should update the quest', () async {
      // arrange
      when(mockDataSource.update(quest: localQuest))
          .thenAnswer((_) async => ());
      // act
      await repository.updateQuest(quest: dailyQuest);
      // assert
      verify(mockDataSource.update(quest: localQuest));
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('add task', () {
    const localTask = LocalTask(title: 'title', description: 'description');
    const task = Task(title: 'title', description: 'description');
    test('should forward add task to datasource', () async {
      // arrange
      when(mockDataSource.addTask(task: localTask))
          .thenAnswer((_) async => localQuest);
      // act
      final result = await repository.addTask(task: task);
      // assert
      expect(result, dailyQuest);
      verify(mockDataSource.addTask(task: localTask));
    });

    test('should throw on adding task fails', () async {
      // arrange
      final exception = Exception('Add task fails');
      when(mockDataSource.addTask(task: localTask)).thenThrow(exception);
      // assert
      expect(() => repository.addTask(task: task), throwsException);
    });
  });

  group('edit task', () {
    const localTask = LocalTask(title: 'title', description: 'description');
    const task = Task(title: 'title', description: 'description');
    test('should forward the edit task message to datasource', () async {
      // arrange
      when(mockDataSource.editTask(task: localTask, index: 0))
          .thenAnswer((_) async => localQuest);
      // act
      final result = await repository.editTask(task: task, index: 0);
      // assert
      expect(result, dailyQuest);
      verify(mockDataSource.editTask(task: localTask, index: 0));
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should throw on editing task fails', () async {
      // arrange
      final exception = Exception('Edit task fails');
      when(mockDataSource.editTask(task: localTask, index: 1))
          .thenThrow(exception);

      // assert
      expect(() => repository.editTask(task: task, index: 1), throwsException);
    });
  });

  group('toggle task', () {
    test('should throw on toggle task fails', () async {
      // arrange
      final exception = Exception('Toggle task fails');
      when(mockDataSource.toggleTask(index: 2)).thenThrow(exception);
      // assert
      expect(() => repository.toggleTask(index: 2), throwsException);
    });

    test('should forward toggle task message to dataSource', () async {
      // arrange
      when(mockDataSource.toggleTask(index: 1))
          .thenAnswer((_) async => localQuest);
      // act
      final result = await repository.toggleTask(index: 1);
      // assert
      expect(result, dailyQuest);
      verify(mockDataSource.toggleTask(index: 1));
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('Remove task', () {
    test('should throw when removing task fails', () async {
      // arrange
      final exception = Exception('Remove task fails');
      when(mockDataSource.removeTask(index: 4)).thenThrow(exception);
      // assert
      expect(() => repository.removeTask(index: 4), throwsException);
    });

    test('should foward remove task message to dataSource', () async {
      // arrange
      when(mockDataSource.removeTask(index: 5))
          .thenAnswer((_) async => localQuest);
      // act
      final result = await repository.removeTask(index: 5);
      // assert
      expect(result, dailyQuest);
      verify(mockDataSource.removeTask(index: 5));
      verifyNoMoreInteractions(mockDataSource);
    });
  });

  group('Move task', () {
    test('should throw when moving task fails', () async {
      // arrange
      final exception = Exception('Remove task fails');
      when(mockDataSource.moveTask(fromIndex: 2, toIndex: 3))
          .thenThrow(exception);
      // assert
      expect(
          () => repository.moveTask(fromIndex: 2, toIndex: 3), throwsException);
    });

    test('should foward remove task message to dataSource', () async {
      // arrange
      when(mockDataSource.moveTask(fromIndex: 2, toIndex: 4))
          .thenAnswer((_) async => localQuest);
      // act
      final result = await repository.moveTask(fromIndex: 2, toIndex: 4);
      // assert
      expect(result, dailyQuest);
      verify(mockDataSource.moveTask(fromIndex: 2, toIndex: 4));
      verifyNoMoreInteractions(mockDataSource);
    });
  });
}
