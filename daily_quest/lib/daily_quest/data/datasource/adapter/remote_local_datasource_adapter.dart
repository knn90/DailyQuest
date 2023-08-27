import 'package:daily_quest/daily_quest/data/datasource/helper/retry_handler.dart';
import 'package:daily_quest/daily_quest/data/datasource/local/daily_quest_local_datasource.dart';
import 'package:daily_quest/daily_quest/data/datasource/remote/daily_quest_remote_datasource.dart';
import 'package:daily_quest/daily_quest/data/model/local/local_daily_quest.dart';
import 'package:daily_quest/daily_quest/data/model/local/local_task.dart';
import 'package:daily_quest/daily_quest/data/model/remote/remote_daily_quest.dart';
import 'package:daily_quest/daily_quest/data/model/remote/remote_task.dart';

final class RemoteLocalDataSourceAdapter implements DailyQuestLocalDataSource {
  final DailyQuestRemoteDataSource _remoteDataSource;
  final DailyQuestLocalDataSource _localDataSource;
  final RetryHandler? _retryHandler;

  RemoteLocalDataSourceAdapter({
    required remoteDataSource,
    required localDataSource,
    RetryHandler? retryHandler,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _retryHandler = retryHandler;

  @override
  Future<LocalDailyQuest> addTask({required LocalTask task}) async {
    final localQuest = await _localDataSource.addTask(task: task);
    final remoteQuest = RemoteDailyQuest(
        timestamp: localQuest.timestamp,
        tasks: localQuest.tasks
            .map((e) => RemoteTask(
                  title: e.title,
                  description: e.description,
                  isDone: e.isDone,
                ))
            .toList());
    _retryHandler
        ?.retryOnThrow(() => _remoteDataSource.updateQuest(quest: remoteQuest));
    return localQuest;
  }

  @override
  Future<LocalDailyQuest> editTask(
      {required LocalTask task, required int index}) {
    // TODO: implement editTask
    throw UnimplementedError();
  }

  @override
  LocalDailyQuest getLast() {
    // TODO: implement getLast
    throw UnimplementedError();
  }

  @override
  Future<void> insert({required LocalDailyQuest quest}) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<LocalDailyQuest> moveTask(
      {required int fromIndex, required int toIndex}) {
    // TODO: implement moveTask
    throw UnimplementedError();
  }

  @override
  Future<LocalDailyQuest> removeTask({required int index}) {
    // TODO: implement removeTask
    throw UnimplementedError();
  }

  @override
  Future<LocalDailyQuest> toggleTask({required int index}) {
    // TODO: implement toggleTask
    throw UnimplementedError();
  }

  @override
  Future<void> update({required LocalDailyQuest quest}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
