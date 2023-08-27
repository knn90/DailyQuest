import 'package:daily_quest/daily_quest/data/datasource/helper/retry_handler.dart';
import 'package:daily_quest/daily_quest/data/datasource/local/daily_quest_local_datasource.dart';
import 'package:daily_quest/daily_quest/data/datasource/remote/daily_quest_remote_datasource.dart';
import 'package:daily_quest/daily_quest/data/datasource/adapter/remote_local_datasource_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../factory/local_quest_factory.dart';
import '../../../../factory/local_task_factory.dart';
import '../../../../factory/remote_quest_factory.dart';
import '../../../../factory/remote_task_factory.dart';
import 'remote_local_datasource_adapter_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DailyQuestRemoteDataSource>(),
  MockSpec<DailyQuestLocalDataSource>(),
  MockSpec<RetryHandler>(),
])
void main() {
  late RemoteLocalDataSourceAdapter sut;
  late MockDailyQuestRemoteDataSource mockRemoteDataSource;
  late MockDailyQuestLocalDataSource mockLocalDataSource;
  late MockRetryHandler mockRetryHandler;
  setUp(() {
    mockRemoteDataSource = MockDailyQuestRemoteDataSource();
    mockLocalDataSource = MockDailyQuestLocalDataSource();
    mockRetryHandler = MockRetryHandler();
    sut = RemoteLocalDataSourceAdapter(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      retryHandler: mockRetryHandler,
    );
  });

  group('addTask', () {
    test('should throw on local datasource throw', () async {
      // arrange
      final task = LocalTaskFactory.make();
      final exception = Exception('add task failed');
      when(mockLocalDataSource.addTask(task: task)).thenThrow(exception);
      // act
      expect(() => sut.addTask(task: task), throwsException);
      // assert
    });

    test('should return correctLocalQuest on local datasource success',
        () async {
      // arrange
      const title = 'title';
      const description = 'description';
      const isDone = true;
      const timestamp = 'timestamp';
      final localTask = LocalTaskFactory.make(
          title: title, description: description, isDone: isDone);
      final localQuest =
          LocalQuestFactory.make(timestamp: timestamp, tasks: [localTask]);
      final remoteTask = RemoteTaskFactory.make(
          title: title, desciption: description, isDone: isDone);
      final remoteQuest = RemoteDailyQuestFactory.make(
          timestamp: timestamp, tasks: [remoteTask]);
      when(mockLocalDataSource.addTask(task: localTask))
          .thenAnswer((_) async => localQuest);
      when(mockRemoteDataSource.updateQuest(quest: remoteQuest))
          .thenAnswer((_) async => ());
      // act
      final result = await sut.addTask(task: localTask);
      // assert
      expect(result, localQuest);
      verify(mockLocalDataSource.addTask(task: localTask));
      verify(mockRetryHandler.retryOnThrow(any)).called(1);
    });

    test('should not throw on remote data source throw', () async {
      // arrange
      const title = 'title';
      const description = 'description';
      const isDone = true;
      const timestamp = 'timestamp';
      final localTask = LocalTaskFactory.make(
          title: title, description: description, isDone: isDone);
      final localQuest =
          LocalQuestFactory.make(timestamp: timestamp, tasks: [localTask]);
      final remoteTask = RemoteTaskFactory.make(
          title: title, desciption: description, isDone: isDone);
      final remoteQuest = RemoteDailyQuestFactory.make(
          timestamp: timestamp, tasks: [remoteTask]);
      final exception = Exception('remote data source fails');
      when(mockLocalDataSource.addTask(task: localTask))
          .thenAnswer((_) async => localQuest);
      when(mockRemoteDataSource.updateQuest(quest: remoteQuest))
          .thenThrow(exception);
      // act
      final result = await sut.addTask(task: localTask);
      // assert
      expect(result, localQuest);
      verify(mockLocalDataSource.addTask(task: localTask));
      verify(mockRetryHandler.retryOnThrow(any)).called(1);
    });
  });

  group('getLast', () {});

  group('insertQuest', () {});

  group('updateQuest', () {});

  group('edit task', () {});

  group('Toggle task', () {});

  group('Remove Task', () {});

  group('moving task', () {});
}
