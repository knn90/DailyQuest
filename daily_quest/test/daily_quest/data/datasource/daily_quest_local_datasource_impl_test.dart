import 'package:daily_quest/daily_quest/data/datasource/daily_quest_local_datasource.dart';
import 'package:daily_quest/daily_quest/data/datasource/daily_quest_local_datasource_impl.dart';
import 'package:daily_quest/daily_quest/data/model/local_daily_quest.dart';
import 'package:daily_quest/daily_quest/data/model/local_task.dart';
import 'package:daily_quest/daily_quest/domain/exception/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

import 'daily_quest_local_datasource_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Box>()])
void main() {
  late DailyQuestLocalDataSource dataSource;
  late MockBox mockBox;
  const task =
      LocalTask(title: 'latest title', description: 'latest description');
  const oldQuest = LocalDailyQuest(timestamp: 'old timestamp', tasks: []);
  const latestQuest = LocalDailyQuest(
    timestamp: 'latest timestamp',
    tasks: [task],
  );
  setUp(() {
    mockBox = MockBox();
    dataSource = DailyQuestLocalDataSourceImpl(box: mockBox);
  });
  group('addTask', () {
    test('should throw DailyQuestNotFound on empty database', () async {
      // arrange
      when(mockBox.length).thenReturn(0);
      when(mockBox.isEmpty).thenReturn(true);
      // act
      // assert
      expect(() => dataSource.addTask(task: task),
          throwsA(isA<DailyQuestNotFound>()));
    });

    test('should append task to the quest', () async {
      // arrange
      const emptyQuest = LocalDailyQuest(timestamp: 'timestamp', tasks: []);
      final addedQuest = emptyQuest.addTask(task);
      when(mockBox.length).thenReturn(1);
      when(mockBox.getAt(0)).thenReturn(emptyQuest);
      // act
      final result = await dataSource.addTask(task: task);
      // assert
      expect(result, addedQuest);
      verify(mockBox.length);
      verify(mockBox.isEmpty);
      verify(mockBox.getAt(0));
      verify(mockBox.putAt(0, addedQuest));
    });
  });

  group('getLast', () {
    test('should get the last inserted quest', () async {
      // arrange
      when(mockBox.length).thenReturn(2);
      when(mockBox.getAt(0)).thenReturn(oldQuest);
      when(mockBox.getAt(1)).thenReturn(latestQuest);
      // act
      final result = dataSource.getLast();
      // assert
      expect(result, latestQuest);
      verify(mockBox.getAt(1));
      verify(mockBox.length);
      verify(mockBox.isEmpty);
      verifyNoMoreInteractions(mockBox);
    });

    test('should throw DailyQuestNotFound on empty database', () async {
      // arrange
      when(mockBox.length).thenReturn(0);
      when(mockBox.isEmpty).thenReturn(true);
      // act
      // assert
      expect(() => dataSource.getLast(), throwsA(isA<DailyQuestNotFound>()));
    });
  });

  group('insertQuest', () {
    test('should insert quest to box', () async {
      // arrange
      when(mockBox.add(latestQuest)).thenAnswer((_) async => 0);
      // act
      dataSource.insert(quest: latestQuest);
      // assert
      verify(mockBox.add(latestQuest));
      verifyNoMoreInteractions(mockBox);
    });

    test('called twice should insert to the box twice', () async {
      // arrange
      when(mockBox.add(oldQuest)).thenAnswer((_) async => 0);
      when(mockBox.add(latestQuest)).thenAnswer((_) async => 0);
      // act
      dataSource.insert(quest: oldQuest);
      dataSource.insert(quest: latestQuest);
      // assert
      verify(mockBox.add(oldQuest));
      verify(mockBox.add(latestQuest));
      verifyNoMoreInteractions(mockBox);
    });
  });

  group('updateQuest', () {
    test('should throw on empty database', () async {
      // arrange
      when(mockBox.isEmpty).thenReturn(true);

      // assert
      expect(() => dataSource.update(quest: oldQuest),
          throwsA(isA<DailyQuestNotFound>()));
    });

    test('should get last daily quest and update with the latest', () async {
      // arrange
      when(mockBox.length).thenReturn(1);
      when(mockBox.putAt(0, latestQuest)).thenAnswer((_) async => ());
      // act
      await dataSource.update(quest: latestQuest);
      // assert
      verifyInOrder([
        mockBox.isEmpty,
        mockBox.length,
        mockBox.putAt(0, latestQuest),
      ]);
      verifyNoMoreInteractions(mockBox);
    });
  });

  group('edit task', () {
    test('should throw on empty database', () {
      // arrange
      when(mockBox.isEmpty).thenReturn(true);
      // assert
      expect(() => dataSource.editTask(task: task, index: 1),
          throwsA(isA<DailyQuestNotFound>()));
    });

    test('should update task at correct index', () async {
      const oldQuest = LocalDailyQuest(timestamp: 'timestamp', tasks: [task]);
      const editedTask =
          LocalTask(title: 'edited title', description: 'edited description');
      const editedQuest =
          LocalDailyQuest(timestamp: 'timestamp', tasks: [editedTask]);
      // arrange
      when(mockBox.length).thenReturn(1);
      when(mockBox.getAt(0)).thenReturn(oldQuest);
      // act
      final result = await dataSource.editTask(task: editedTask, index: 0);
      // assert
      expect(result, editedQuest);
      verifyInOrder([
        mockBox.isEmpty,
        mockBox.length,
        mockBox.getAt(0),
        mockBox.putAt(0, editedQuest),
      ]);
      verifyNoMoreInteractions(mockBox);
    });
  });

  group('Toggle task', () {
    test('should throw on empty database', () {
      // arrange
      when(mockBox.isEmpty).thenReturn(true);
      // assert
      expect(() => dataSource.toggleTask(index: 1),
          throwsA(isA<DailyQuestNotFound>()));
    });

    test('should toggle state of the task', () async {
      // arrange
      const task =
          LocalTask(title: 'title', description: 'description', isDone: false);
      const quest = LocalDailyQuest(timestamp: 'timestamp', tasks: [task]);
      const finishedTask =
          LocalTask(title: 'title', description: 'description', isDone: true);
      const finishedQuest =
          LocalDailyQuest(timestamp: 'timestamp', tasks: [finishedTask]);
      when(mockBox.length).thenReturn(1);
      when(mockBox.getAt(0)).thenReturn(quest);
      // act
      final result = await dataSource.toggleTask(index: 0);
      // assert;
      expect(result.tasks[0].isDone, true);
      expect(result, finishedQuest);
      verifyInOrder([
        mockBox.isEmpty,
        mockBox.length,
        mockBox.getAt(0),
        mockBox.putAt(0, finishedQuest),
      ]);
      verifyNoMoreInteractions(mockBox);
    });
  });

  group('Remove Task', () {
    test('should throw on empty database', () {
      // arrange
      when(mockBox.isEmpty).thenReturn(true);
      // assert
      expect(() => dataSource.removeTask(index: 1),
          throwsA(isA<DailyQuestNotFound>()));
      verify(mockBox.isEmpty);
      verifyNoMoreInteractions(mockBox);
    });

    test('should throw when removing on quest with empty task', () async {
      // arrange
      const emptyQuest = LocalDailyQuest(timestamp: 'timestamp', tasks: []);
      when(mockBox.length).thenReturn(1);
      when(mockBox.getAt(0)).thenReturn(emptyQuest);

      // assert
      expect(() => dataSource.removeTask(index: 0),
          throwsA(isA<TaskIndexOutOfBound>()));
    });

    test('should throw when removing on quest with out of bound index',
        () async {
      // arrange
      const quest = LocalDailyQuest(
          timestamp: 'timestamp',
          tasks: [LocalTask(title: 'title', description: 'description')]);
      when(mockBox.length).thenReturn(1);
      when(mockBox.getAt(0)).thenReturn(quest);

      // assert
      expect(() => dataSource.removeTask(index: 2),
          throwsA(isA<TaskIndexOutOfBound>()));
    });

    test('should remove the task at index', () async {
      // arrange
      const quest = LocalDailyQuest(
          timestamp: 'timestamp',
          tasks: [LocalTask(title: 'title', description: 'description')]);
      const removedQuest = LocalDailyQuest(timestamp: 'timestamp', tasks: []);
      when(mockBox.length).thenReturn(1);
      when(mockBox.getAt(0)).thenReturn(quest);
      // act
      final result = await dataSource.removeTask(index: 0);
      // assert
      expect(result, removedQuest);
      verifyInOrder([
        mockBox.isEmpty,
        mockBox.length,
        mockBox.getAt(0),
        mockBox.putAt(0, removedQuest),
      ]);
      verifyNoMoreInteractions(mockBox);
    });
  });
}
