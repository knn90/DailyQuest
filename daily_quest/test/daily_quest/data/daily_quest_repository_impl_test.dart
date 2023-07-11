import 'package:daily_quest/daily_quest/domain/entity/daily_quest.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';
import 'package:daily_quest/daily_quest/domain/repository/daily_quest_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'daily_quest_repository_impl_test.mocks.dart';

class DailyQuestRepositoryImpl implements DailyQuestRepository {
  final DailyQuestLocalDataSource dataSource;

  DailyQuestRepositoryImpl({required this.dataSource});

  @override
  Future<DailyQuest> getLastDailyQuest() async {
    final localQuest = await dataSource.getLast();
    final tasks = localQuest.tasks
        .map((e) => Task(title: e.title, description: e.description))
        .toList();
    return DailyQuest(
        id: localQuest.id, timestamp: localQuest.timestamp, tasks: tasks);
  }

  @override
  Future<void> saveDailyQuest({required DailyQuest quest}) {
    // TODO: implement saveDailyQuest
    throw UnimplementedError();
  }
}

class LocalTask {
  final String title;
  final String description;
  final bool isDone = false;

  LocalTask({required this.title, required this.description});

  Task toEntity() {
    return Task(title: title, description: description);
  }
}

class LocalDailyQuest {
  final String id;
  final String timestamp;
  final List<LocalTask> tasks;

  LocalDailyQuest(
      {required this.id, required this.timestamp, required this.tasks});
  DailyQuest toEntity() {
    return DailyQuest(
        id: id,
        timestamp: timestamp,
        tasks: tasks.map((e) => e.toEntity()).toList());
  }
}

abstract class DailyQuestLocalDataSource {
  Future<LocalDailyQuest> getLast();
  save({required LocalDailyQuest quest});
}

class DailyQuestNotFound implements Exception {}

@GenerateNiceMocks([MockSpec<DailyQuestLocalDataSource>()])
void main() {
  late DailyQuestRepositoryImpl repository;
  late MockDailyQuestLocalDataSource mockDataSource;
  final LocalDailyQuest localQuest =
      LocalDailyQuest(id: 'any id', timestamp: 'any timestamp', tasks: []);
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
      test('should return last inserted daily quest', () async {
        // arrange
        // when(mockDataSource.getLast()).thenAnswer((_) async => localQuest);
        // // act
        // final result = await repository.getLastDailyQuest();
        // // assert
        // expect(result, dailyQuest);
        // verifyNoMoreInteractions(mockDataSource);
      });
    });
  });
}
