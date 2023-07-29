import 'package:daily_quest/daily_quest/data/model/local_task.dart';
import 'package:daily_quest/daily_quest/domain/entity/task.dart';

import '../../domain/entity/daily_quest.dart';
import '../../domain/repository/daily_quest_repository.dart';
import '../datasource/daily_quest_local_datasource.dart';
import '../model/local_daily_quest.dart';

class DailyQuestRepositoryImpl implements DailyQuestRepository {
  final DailyQuestLocalDataSource dataSource;

  DailyQuestRepositoryImpl({required this.dataSource});

  @override
  Future<DailyQuest> getLastDailyQuest() {
    final localQuest = dataSource.getLast();
    final tasks = localQuest.tasks.map((e) => e.toEntity()).toList();
    return Future.value(DailyQuest(
      timestamp: localQuest.timestamp,
      tasks: tasks,
    ));
  }

  @override
  insertDailyQuest({required DailyQuest quest}) {
    return dataSource.insert(quest: LocalDailyQuest.fromEntity(quest));
  }

  @override
  Future<void> updateQuest({required DailyQuest quest}) {
    return dataSource.update(quest: LocalDailyQuest.fromEntity(quest));
  }

  @override
  Future<DailyQuest> addTask({required Task task}) async {
    final quest = await dataSource.addTask(task: LocalTask.fromEntity(task));
    return quest.toEntity();
  }

  @override
  Future<DailyQuest> editTask({required Task task, required int index}) async {
    final localQuest = await dataSource.editTask(
      task: LocalTask.fromEntity(task),
      index: index,
    );
    return localQuest.toEntity();
  }

  @override
  Future<DailyQuest> toggleTask({required int index}) async {
    final localQuest = await dataSource.toggleTask(index: index);
    return localQuest.toEntity();
  }

  @override
  Future<DailyQuest> removeTask({required int index}) async {
    final localQuest = await dataSource.removeTask(index: index);
    return localQuest.toEntity();
  }

  @override
  Future<DailyQuest> moveTask(
      {required int fromIndex, required int toIndex}) async {
    final localQuest =
        await dataSource.moveTask(fromIndex: fromIndex, toIndex: toIndex);
    return localQuest.toEntity();
  }
}
